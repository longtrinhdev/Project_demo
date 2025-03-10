const mongoose = require("mongoose");

const lessonSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    isCompleted: {
      type: Boolean,
      default: false,
    },
    isUnlocked: {
      type: Boolean,
      default: false,
    },
    questionId: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Question",
      },
    ],
    sectionId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Section",
    },
  },
  { timestamp: true }
);

// export
const Lesson = mongoose.model("Lesson", lessonSchema);
module.exports = Lesson;
