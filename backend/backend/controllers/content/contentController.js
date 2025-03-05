const Content = require("../../models/content/chapterContent");
const Chapter = require("../../models/chapter/chapter");

const chapterController = {
  // ?add content to chapter
  addContentChapter: async (req, res) => {
    try {
      const newContentChapter = new Content(req.body);
      const saveContentChapter = await newContentChapter.save();
      await Chapter.findByIdAndUpdate(req.body.chapterId, {
        $push: { chapterContent: saveContentChapter._id },
      });
      return res
        .status(200)
        .json({ message: "Add content to chapter successfully! " });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?get all content in chapter
  getAllContentChapter: async (req, res) => {
    try {
      const chapter = await Chapter.findById(req.params.id);
      if (!chapter) {
        return res.status(404).json({ message: "Chapter not found" });
      }
      const contentChapter = await Content.find({
        _id: { $in: chapter.chapterContent },
      });
      return res.status(200).json(contentChapter);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? update content in chapter
  updateContentChapter: async (req, res) => {
    try {
      const contentChapter = await Content.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true }
      );
      if (!contentChapter) {
        return res.status(404).json({ message: "Content not found" });
      }
      return res.status(200).json(contentChapter);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? delete content in chapter
  deleteContentChapter: async (req, res) => {
    try {
      const contentChapter = await Content.findByIdAndDelete(req.params.id);
      if (!contentChapter) {
        return res.status(404).json({ message: "Content not found" });
      }
      await Chapter.findByIdAndUpdate(req.body.chapterId, {
        $pull: { chapterContent: req.params.id },
      });
      return res
        .status(200)
        .json({ message: "Delete content in chapter successfully" });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },
};

// export
module.exports = chapterController;
