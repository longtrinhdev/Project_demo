const Lesson = require("../../models/lesson/lesson");
const Chapter = require("../../models/chapter/chapter");

const lessonController = {
  // ?add lesson to chapter
  addLesson: async (req, res) => {
    try {
      const newLesson = new Lesson(req.body);
      const saveLesson = await newLesson.save();
      await Chapter.findByIdAndUpdate(req.body.chapterId, {
        $push: { lessons: saveLesson._id },
      });
      res.status(200).json({ message: "Add lesson successfully! " });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: "Server Error" });
    }
  },

  //? get all lessons in a chapter
  getAllLessons: async (req, res) => {
    try {
      const chapter = await Chapter.findById(req.params.id);
      if (!chapter) {
        return res.status(404).json({ message: "Chapter not found" });
      }
      const lesson = await Lesson.find({
        _id: { $in: chapter.lessons },
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

  // ? update lesson in chapter
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
      await Chapter.findByIdAndUpdate(lesson.chapterId, {
        $pull: { lessons: lesson._id },
      });
      res.status(200).json({ message: "Lesson deleted successfully!" });
    } catch (error) {
      res.status(500).json({ message: "Server Error" });
    }
  },
};

// export
module.exports = lessonController;
