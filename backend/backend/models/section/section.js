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
    questions: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Question",
      },
    ],
  },
  { timestamp: true }
);

const sectionSchema = mongoose.Schema(
  {
    image: {
      type: String,
      required: true,
      unique: true,
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
    color: {
      type: String,
      required: true,
    },
    chapter: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Chapter",
    },
    lessons: [lessonSchema],
    sectionContent: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Content",
      },
    ],
  },
  { timestamp: true }
);

//export

const Section = mongoose.model("Section", sectionSchema);
module.exports = Section;
