const mongoose = require("mongoose");

const chapterContentSchema = mongoose.Schema(
  {
    content: {
      type: String,
      required: true,
      unique: true,
    },
    meaning: {
      type: String,
      required: true,
      unique: true,
    },
    audio: {
      type: String,
      required: true,
      unique: true,
    },
    chapterId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Chapter",
    },
  },
  { timestamp: true }
);

// export
const chapterContent = mongoose.model("Content", chapterContentSchema);
module.exports = chapterContent;
