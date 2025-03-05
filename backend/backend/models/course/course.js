const mongoose = require("mongoose");

const courseSchema = mongoose.Schema(
  {
    image: {
      type: "string",
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    userIds: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
    ],
    idChapters: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Chapter",
      },
    ],
    vowelIds: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Syllable",
      },
    ],
    consonantIds: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Syllable",
      },
    ],
  },
  { timestamps: true }
);

const Course = mongoose.model("Course", courseSchema);
module.exports = Course;
