const Lesson = require("../../models/lesson/lesson");
const Section = require("../../models/section/section");

const lessonController = {
  // ?add lesson to section
  addLesson: async (req, res) => {
    try {
      const newLesson = new Lesson(req.body);
      const saveLesson = await newLesson.save();
      await Section.findByIdAndUpdate(req.body.sectionId, {
        $push: { lessonIds: saveLesson._id },
      });
      res.status(200).json({ message: "Add lesson successfully! " });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Server Error" });
    }
  },

  //? get all lessons in a section
  getAllLessons: async (req, res) => {
    try {
      const section = await Section.findById(req.params.id);
      if (!section) {
        return res.status(404).json({ message: "Section not found" });
      }
      const lesson = await Lesson.find({
        _id: { $in: section.lessonIds },
      });
      res.status(200).json(lesson);
    } catch (error) {
      res.status(500).json({ message: "Server Error" });
    }
  },

  //? get lesson by id
  getLessonById: async (req, res) => {
    try {
      const lesson = await Lesson.findById(req.params.id);
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found" });
      }
      res.status(200).json(lesson);
    } catch (error) {
      res.status(500).json({ message: "Server Error" });
    }
  },

  // ? update lesson in section
  updateLesson: async (req, res) => {
    try {
      const lesson = await Lesson.findByIdAndUpdate(req.params.id, req.body, {
        new: true,
      });
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found" });
      }
      res.status(200).json(lesson);
    } catch (error) {
      res.status(500).json({ message: "Server Error" });
    }
  },

  //? delete lesson
  deleteLesson: async (req, res) => {
    try {
      const lesson = await Lesson.findByIdAndDelete(req.params.id);
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found" });
      }
      await Section.findByIdAndUpdate(lesson.sectionId, {
        $pull: { lessonIds: lesson._id },
      });
      res.status(200).json({ message: "Lesson deleted successfully!" });
    } catch (error) {
      res.status(500).json({ message: "Server Error" });
    }
  },
};

// export
module.exports = lessonController;
