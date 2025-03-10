const mongoose = require("mongoose");

const sectionContentSchema = mongoose.Schema(
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
    sectionId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Section",
    },
  },
  { timestamp: true }
);

// export
const chapterContent = mongoose.model("Content", sectionContentSchema);
module.exports = chapterContent;
