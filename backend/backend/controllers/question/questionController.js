const Question = require("../../models/question/question");
const Lesson = require("../../models/lesson/lesson");
const Syllable = require("../../models/syllable/syllable");

const questionController = {
  // ?add question to lesson
  addQuestionToLesson: async (req, res) => {
    try {
      const newQuestion = new Question(req.body);
      const saveQuestion = await newQuestion.save();
      await Lesson.findByIdAndUpdate(req.body.lessonId, {
        $push: { questionId: saveQuestion._id },
      });
      return res
        .status(200)
        .json({ message: "Add question to lesson successfully! " });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?add question to syllable
  addQuestionToSyllable: async (req, res) => {
    try {
      const newQuestion = new Question(req.body);
      const saveQuestion = await newQuestion.save();
      await Syllable.findByIdAndUpdate(req.body.syllableId, {
        $push: { questionId: saveQuestion._id },
      });
      return res
        .status(200)
        .json({ message: "Add question to syllable successfully! " });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?get all question by lesson id
  getAllQuestionsByLessonId: async (req, res) => {
    try {
      const lesson = await Lesson.findById({ lessonId: req.params.id });
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found " });
      }
      const questions = await Question.find({
        _id: { $in: lesson.questionId },
      });
      return res.status(200).json(questions);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?get all question by syllable id
  getAllQuestionsBySyllableId: async (req, res) => {
    try {
      const syllable = await Syllable.findById({ syllableId: req.params.id });
      if (!syllable) {
        return res.status(404).json({ message: "Syllable not found " });
      }
      const questions = await Question.find({
        _id: { $in: syllable.questionId },
      });
      return res.status(200).json(questions);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?get question by id
  getQuestionById: async (req, res) => {
    try {
      const question = await Question.findById(req.params.id);
      if (!question) {
        return res.status(404).json({ message: "Question not found " });
      }
      return res.status(200).json(question);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?update question by id
  updateQuestionById: async (req, res) => {
    try {
      const question = await Question.findByIdAndUpdate(
        req.params.id,
        req.body,
        {
          new: true,
        }
      );
      if (!question) {
        return res.status(404).json({ message: "Question not found " });
      }
      return res.status(200).json(question);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?delete question by lesson id
  deleteQuestionByLessonId: async (req, res) => {
    try {
      const question = await Question.findByIdAndDelete(req.params.id);
      if (!question) {
        return res.status(404).json({ message: "Question not found " });
      }
      await Lesson.findByIdAndUpdate(req.body.lessonId, {
        $pull: { questionId: req.params.id },
      });
      return res
        .status(200)
        .json({ message: "Question deleted successfully! " });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },

  // ?delete question by syllable id
  deleteQuestionBySyllableId: async (req, res) => {
    try {
      const question = await Question.findByIdAndDelete(req.params.id);
      if (!question) {
        return res.status(404).json({ message: "Question not found " });
      }
      await Syllable.findByIdAndUpdate(req.body.syllableId, {
        $pull: { questionId: req.params.id },
      });
      return res
        .status(200)
        .json({ message: "Question deleted successfully! " });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Server Error" });
    }
  },
};

//export
module.exports = questionController;
