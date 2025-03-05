const jwt = require("jsonwebtoken");

const middlewareController = {
  verifyToken: (req, res, next) => {
    const token = req.headers.token;

    if (!token) {
      return res.status(401).json({
        message: "Token is missing! ",
      });
    }
    const accessToken = token.split(" ")[1];
    if (!accessToken) {
      return res.status(401).json({
        message: "Invalid token format! ",
      });
    }

    jwt.verify(accessToken, process.env.JWT_ACCESS_TOKEN, (error, user) => {
      if (error) {
        if (error.name === "TokenExpiredError") {
          return res.status(403).json({
            message: "Token expired! ",
          });
        }
        if (error.name === "JsonWebTokenError") {
          return res.status(403).json({
            message: "Invalid token! ",
          });
        }
        return res.status(403).json({ message: "Token verification failed! " });
      }
      req.user = user;
      next();
    });
  },
};

// export
module.exports = middlewareController;
