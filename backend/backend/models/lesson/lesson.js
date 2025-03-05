const mongoose = require("mongoose");

const lessonSchema = mongoose.Schema(
  {
    avatar: {
      type: String,
      required: true,
    },
    title: {
      type: String,
      required: true,
      unique: true,
    },
    isCompleted: {
      type: Boolean,
      default: false,
    },
    questionId: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Question",
      },
    ],
    chapterId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Chapter",
    },
  },
  { timestamp: true }
);

// export
const Lesson = mongoose.model("Lesson", lessonSchema);
module.exports = Lesson;
