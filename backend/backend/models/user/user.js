const mongoose = require("mongoose");
const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    username: {
      type: String,
      unique: true,
    },
    email: {
      type: String,
      required: true,
      minlength: 12,
      unique: true,
    },
    password: {
      type: String,
      minlength: 8,
    },
    bio: {
      type: String,
    },
    score: {
      type: Number,
      default: 0,
    },
    followers: [
      {
        type: String,
      },
    ],
    followings: [
      {
        type: String,
      },
    ],
    learnDays: [
      {
        type: String,
      },
    ],
    courseId: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Course",
      },
    ],
  },
  { timestamps: true }
);

// export
const User = mongoose.model("User", userSchema);
module.exports = User;
