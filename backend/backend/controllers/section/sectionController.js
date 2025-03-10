const Section = require("../../models/section/section");
const Chapter = require("../../models/chapter/chapter");

const sectionController = {
  // add section to chapter
  addSection: async (req, res) => {
    try {
      const newSection = new Section(req.body);
      const saveSection = await newSection.save();
      await Chapter.findByIdAndUpdate(req.body.chapterId, {
        $push: { sectionIds: saveSection._id },
      });
      res.status(200).json({ message: "Add section successfully! " });
    } catch (error) {
      console.log(error);
    }
  },

  // get all sections of chapter
  getAllSections: async (req, res) => {
    try {
      const chapter = await Chapter.findById(req.params.id);
      if (!chapter) {
        return res.status(404).json({ message: "Chapter not found" });
      }
      const sections = await Section.find({ _id: { $in: chapter.sectionIds } });
      res.status(200).json(sections);
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Server Error" });
    }
  },

  // update section by id
  updateSection: async (req, res) => {
    try {
      const section = await Section.findByIdAndUpdate(req.params.id, req.body, {
        new: true,
      });
      if (!section) {
        return res.status(404).json({ message: "Section not found" });
      }
      res.status(200).json(section);
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Server Error" });
    }
  },

  // delete section by id
  deleteSection: async (req, res) => {
    try {
      const section = await Section.findByIdAndDelete(req.params.id);
      if (!section) {
        return res.status(404).json({ message: "Section not found" });
      }
      await Chapter.findByIdAndUpdate(section.chapterId, {
        $pull: { sectionIds: section._id },
      });
      res.status(200).json({ message: "Section deleted successfully! " });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Server Error" });
    }
  },
};

// export
module.exports = sectionController;
