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
  },
  video: {
    type: String,
  },
  image: {
    type: String,
  },
  manual: {
    type: String,
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
