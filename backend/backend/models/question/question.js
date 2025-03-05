const mongoose = require("mongoose");

const questionSchema = mongoose.Schema(
  {
    image: {
      type: "string",
    },
    question: {
      type: String,
      required: true,
      unique: true,
    },
    answer: {
      type: String,
      required: true,
      unique: true,
    },
    wrongAnswer: [
      {
        type: String,
        required: true,
        unique: true,
      },
    ],
    audio: {
      type: String,
    },
    isCompleted: {
      type: Boolean,
      default: false,
    },
    lessonId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Lesson",
    },
    syllableId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Syllable",
    },
  },
  { timestamp: true }
);

//export
const Question = mongoose.model("Question", questionSchema);
module.exports = Question;
