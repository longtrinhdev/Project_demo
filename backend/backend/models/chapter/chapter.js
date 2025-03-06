const mongoose = require("mongoose");

const chapterSchema = mongoose.Schema(
  {
    avatar: {
      type: String,
      required: true,
    },
    name: {
      type: String,
      required: true,
      unique: true,
    },
    title: {
      type: String,
      required: true,
      unique: true,
    },
    isCompleted: {
      type: Boolean,
      required: true,
      default: false,
    },
    isUnlocked: {
      type: Boolean,
      required: true,
      default: false,
    },
    color: {
      type: String,
      required: true,
    },
    courseId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Course",
    },
    chapterContent: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Content",
      },
    ],
    lessons: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Lesson",
      },
    ],
  },
  { timestamp: true }
);

// export
const Chapter = mongoose.model("Chapter", chapterSchema);
module.exports = Chapter;
