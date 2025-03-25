const User = require("../../models/user/user");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const crypto = require("crypto");
const nodemailer = require("nodemailer");
const authService = require("../../services/authService");

dotenv.config();
let saveRefreshTokens = [];

const authController = {
  // ? register
  registerUser: async (req, res) => {
    try {
      const users = await User.findOne({ username: req.body.username });
      if (users) {
        return res.status(403).json({ message: "Username exist! " });
      }

      const salt = await bcrypt.genSalt(10);
      const hashedPW = await bcrypt.hash(req.body.password, salt);

      const newUser = await new User({
        name: req.body.name,
        username: req.body.username,
        email: req.body.email,
        bio: req.body.bio,
        password: hashedPW,
      });

      await newUser.save();
      await User.findByIdAndUpdate(newUser._id, {
        $push: { courseId: req.body.courseId },
      });

      return res.status(200).json(true);
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: error });
    }
  },

  // ?Sign In
  signInUser: async (req, res) => {
    try {
      const user =
        (await User.findOne({ username: req.body.username })) ||
        (await User.findOne({ email: req.body.username }));

      if (!user) {
        return res.status(404).json({
          message: "Wrong username or email",
        });
      }
      const validPass = await bcrypt.compare(req.body.password, user.password);
      if (!validPass) {
        return res.status(404).json({
          message: "Wrong password",
        });
      }

      if (user && validPass) {
        const accessToken = authController.generateAccessToken(user);
        const refreshToken = authController.generateRefreshToken(user);

        saveRefreshTokens.push(refreshToken);
        console.log(saveRefreshTokens.length);

        const {
          name,
          password,
          username,
          email,
          bio,
          followers,
          followings,
          ...others
        } = user._doc;

        return res.status(200).json({
          user: others,
          accessToken,
          refreshToken,
        });
      }
    } catch (error) {
      return res.status(500).json("Internal Server Error");
    }
  },

  checkEmail: async (req, res) => {
    try {
      const email = req.body.email;
      const gmailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
      if (!gmailPattern.test(email)) {
        return res.status(400).json({ message: "Invalid email!" });
      }

      const user = await User.findOne({ email: req.body.email });
      if (user) {
        return res.status(200).json(true);
      }
      return res.status(200).json(false);
    } catch (error) {
      return res.status(500).json("Internal Server Error");
    }
  },

  // ?logout
  logoutUser: (req, res) => {
    try {
      const refreshToken = req.body;
      if (!refreshToken) {
        return res.status(403).json({ message: "Miss refresh token" });
      }
      saveRefreshTokens = saveRefreshTokens.filter(
        (token) => token !== refreshToken
      );

      return res.status(200).json(true);
    } catch (error) {
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?forgot password
  forgotPassword: async (req, res) => {
    try {
      const email = req.body.email;
      const formatEmail = email.includes("@gmail.com");
      if (!formatEmail) {
        return res.status(403).json({ message: "Incorrect Email Format" });
      }
      const user = await User.findOne({ email: email });
      if (!user) {
        return res.status(404).json({ message: "User Not found" });
      }

      const password = crypto.randomBytes(8).toString("hex");
      const salt = await bcrypt.genSalt(10);
      const hashedPW = await bcrypt.hash(password, salt);
      user.password = hashedPW;
      await user.save();

      const transporter = nodemailer.createTransport({
        service: "gmail",
        secure: true,
        auth: {
          user: process.env.RS_EMAIL,
          pass: process.env.RS_PW,
        },
      });

      const receiver = {
        from: process.env.RS_EMAIL,
        to: email,
        subject: "LETTER: RESET PASSWORD REQUEST",
        text: `Your new password is: ${password}`,
      };

      await transporter.sendMail(receiver);

      return res.status(200).json({
        message: "Password Reset Successful",
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?change password
  changePassword: async (req, res) => {
    try {
      const { oldPassword, newPassword } = req.body;
      const user = await User.findOne(req.user.username);

      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      const validPassword = await bcrypt.compare(oldPassword, user.password);
      if (!validPassword) {
        return res.status(403).json({ message: "Wrong old password" });
      }

      const salt = await bcrypt.genSalt(10);
      const hashedPW = await bcrypt.hash(newPassword, salt);
      user.password = hashedPW;
      await user.save();

      return res.status(200).json({ message: "Change Password Success" });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?get refresh token again
  requestNewToken: async (req, res) => {
    try {
      const refresh_token = req.body.refreshToken;
      if (!refresh_token) {
        return res.status(401).json({ message: "Miss refresh token! " });
      }
      console.log(saveRefreshTokens.length);
      if (!saveRefreshTokens.includes(refresh_token)) {
        return res.status(403).json({ message: "Invalid refresh token! " });
      }

      jwt.verify(
        refresh_token,
        process.env.JWT_REFRESH_TOKEN,
        (error, user) => {
          if (error) {
            return;
          }

          saveRefreshTokens = saveRefreshTokens.filter(
            (token) => token !== refresh_token
          );

          // generate new token
          const newAccessToken = authController.generateAccessToken(user);
          const newRefreshToken = authController.generateRefreshToken(user);

          saveRefreshTokens.push(newRefreshToken);

          return res.status(200).json({
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
            message: "Generate New Token Success",
          });
        }
      );
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?sign in with Google account
  signInGoogleUser: async (req, res) => {
    try {
      const { idToken } = req.body;
      if (!idToken)
        return res.status(400).json({ message: "IdToken is missing! " });
      const ticket = await authService.verifyGoogleIdToken(idToken);
      const payload = ticket.getPayload();
      if (!payload) {
        return res.status(401).json({ message: "Invalid Google token" });
      }

      const user = await authController.saveDataUser(payload);
      const accessToken = authController.generateAccessToken(user);
      const refreshToken = authController.generateRefreshToken(user);
      const {
        name,
        password,
        username,
        email,
        bio,
        followers,
        followings,
        ...others
      } = user._doc;

      return res.status(200).json({
        user: others,
        accessToken,
        refreshToken,
      });
    } catch (error) {
      console.log("Error", error);
      return res
        .status(500)
        .json({ message: "Internal Server Error! ", error: error.message });
    }
  },

  // ?search for name or username
  searchFriendly: async (req, res) => {
    try {
      const { query } = req.query;
      if (!query) {
        return res.status(400).json({ message: "Missing search query" });
      }
      const users = await User.find({
        $or: [
          { name: { $regex: query, $options: "i" } },
          { username: { $regex: query, $options: "i" } },
        ],
      });
      return res.status(200).json(users);
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?order by score
  orderUserByScore: async (req, res) => {
    try {
      const users = await User.find({}).sort({ score: -1 });
      return res.status(200).json(users);
    } catch (error) {
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?update profile user
  updateCourseAndBio: async (req, res) => {
    try {
      const user = await User.findByIdAndUpdate(
        req.body._id,
        {
          $push: { courseId: req.body.courseId },
        },
        { new: true }
      );
      // user.courseId.push(req.body.courseId);
      if (!user) return res.status(404).json({ message: "User Not Found" });
      user.bio = req.body.bio;
      await user.save();
      return res.status(200).json(user);
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // generate access token
  generateAccessToken: (user) => {
    return jwt.sign(
      {
        id: user.id,
      },
      process.env.JWT_ACCESS_TOKEN,
      { expiresIn: "7h" }
    );
  },

  // generate refresh token
  generateRefreshToken: (user) => {
    return jwt.sign(
      {
        id: user.id,
      },
      process.env.JWT_REFRESH_TOKEN,
      { expiresIn: "7d" }
    );
  },

  // save data user when signin with Google account
  async saveDataUser(payload) {
    const { email, name } = payload;
    let user = await User.findOne({ email: email });

    if (!user) {
      const newUser = new User({ name, email });
      await newUser.save();
      return newUser;
    } else {
      user.email = email;
      user.name = name;
      user.username = name;
      await user.save();
      return user;
    }
  },
};

// export
module.exports = authController;
