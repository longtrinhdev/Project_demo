const Course = require("../../models/course/course");
const Chapter = require("../../models/chapter/chapter");

const chapterController = {
  // ? add chapter
  addChapter: async (req, res) => {
    try {
      const newChapter = new Chapter(req.body);
      const saveChapter = await newChapter.save();
      await Course.findByIdAndUpdate(req.body.courseId, {
        $push: { idChapters: saveChapter._id },
      });
      res.status(200).json({ message: "Add chapter successfully! " });
    } catch (error) {
      console.log(error);
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? get all chapters
  getAllChapters: async (req, res) => {
    try {
      const course = await Course.findById(req.params.id);
      if (!course) {
        return res.status(404).json({ message: "Course not found" });
      }
      const chapters = await Chapter.find({
        _id: { $in: course.idChapters },
      });

      res.status(200).json(chapters);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? get chapter by id
  getChapterById: async (req, res) => {
    try {
      const chapter = await Chapter.findById(req.params.id);
      if (!chapter) {
        return res.status(404).json({ message: "Chapter not found" });
      }
      res.status(200).json(chapter);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? update chapter
  updateChapter: async (req, res) => {
    try {
      const chapter = await Chapter.findByIdAndUpdate(req.params.id, req.body, {
        new: true,
      });
      if (!chapter) {
        return res.status(404).json({ message: "Chapter not found" });
      }
      res.status(200).json(chapter);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? delete chapter
  deleteChapter: async (req, res) => {
    try {
      const chapter = await Chapter.findByIdAndDelete(req.params.id);
      if (!chapter) {
        return res.status(404).json({ message: "Chapter not found" });
      }
      await Course.findByIdAndUpdate(chapter.courseId, {
        $pull: { idChapters: req.params.id },
      });
      res.status(200).json({ message: "Delete chapter successfully! " });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },
};

//export
module.exports = chapterController;
