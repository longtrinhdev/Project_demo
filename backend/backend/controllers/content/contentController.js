const Content = require("../../models/content/sectionContent");
const Section = require("../../models/section/section");

const contentController = {
  // ?add content to section
  addContent: async (req, res) => {
    try {
      const newContent = new Content(req.body);
      const saveContent = await newContent.save();
      await Section.findByIdAndUpdate(req.body.sectionId, {
        $push: { sectionContent: saveContent._id },
      });
      return res
        .status(200)
        .json({ message: "Add content to section successfully! " });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?get all content in section
  getAllContent: async (req, res) => {
    try {
      const section = await Section.findById(req.params.id);
      if (!section) {
        return res.status(404).json({ message: "Section not found" });
      }
      const contentSection = await Content.find({
        _id: { $in: section.sectionContent },
      });
      return res.status(200).json(contentSection);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? update content in chapter
  updateContent: async (req, res) => {
    try {
      const contentSection = await Content.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true }
      );
      if (!contentSection) {
        return res.status(404).json({ message: "Content not found" });
      }
      return res.status(200).json(contentSection);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? delete content in section
  deleteContent: async (req, res) => {
    try {
      const contentSection = await Content.findByIdAndDelete(req.params.id);
      if (!contentSection) {
        return res.status(404).json({ message: "Content not found" });
      }
      await Section.findByIdAndUpdate(req.body.sectionId, {
        $pull: { sectionContent: req.params.id },
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
module.exports = contentController;
