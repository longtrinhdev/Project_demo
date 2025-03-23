const mongoose = require("mongoose");

const questionSchema = mongoose.Schema(
  {
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
    isCompleted: {
      type: Boolean,
      default: false,
    },
    syllable: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Syllable",
    },
  },
  { timestamp: true }
);

//export
const Question = mongoose.model("Question", questionSchema);
module.exports = Question;
