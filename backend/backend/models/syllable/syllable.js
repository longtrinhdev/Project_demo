const mongoose = require("mongoose");

const syllableSchema = mongoose.Schema({
  word: {
    type: String,
    required: true,
    unique: true,
  },
  example: {
    type: String,
    required: true,
    unique: true,
  },
  audio: {
    type: String,
    required: true,
    unique: true,
  },
  video: {
    type: String,
    required: true,
    unique: true,
  },
  image: {
    type: String,
    required: true,
    unique: true,
  },
  manual: {
    type: String,
    required: true,
  },
  questionId: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Question",
    },
  ],
  courseId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Course",
  },
});

// export
const Syllable = mongoose.model("Syllable", syllableSchema);
module.exports = Syllable;
