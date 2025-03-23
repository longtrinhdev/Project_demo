const Question = require("../../models/question/question");
const Section = require("../../models/section/section");
const Syllable = require("../../models/syllable/syllable");

const questionController = {
  // ?add question to lesson
  addQuestionToLesson: async (req, res) => {
    try {
      const {
        sectionId,
        lessonId,
        question,
        answer,
        wrongAnswer,
        isCompleted,
      } = req.body;
      const newQuestion = new Question({
        lessonId,
        question,
        answer,
        wrongAnswer,
        isCompleted,
      });
      const saveQuestion = await newQuestion.save();
      const section = await Section.findById(sectionId);
      if (!section) {
        return res.status(404).json({ message: "Section not found " });
      }
      const lesson = section.lessons.id(lessonId);
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found in Section" });
      }

      lesson.questions.push(saveQuestion._id);

      await section.save();
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
      const { sectionId, lessonId } = req.params;
      const section = await Section.findById(sectionId);
      if (!section) {
        return res.status(404).json({ message: "Section not found " });
      }
      const lesson = section.lessons.id(lessonId);
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found " });
      }
      const questions = await Question.find({
        _id: { $in: lesson.questions },
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
      const { sectionId, lessonId, questionId } = req.params;
      const section = await Section.findById(sectionId);
      if (!section) {
        return res.status(404).json({ message: "Section not found" });
      }
      const lesson = section.lessons.id(lessonId);
      if (!lesson) {
        return res.status(404).json({ message: "Lesson not found in Section" });
      }
      const questionIndex = lesson.questions.indexOf(questionId);
      if (questionIndex === -1) {
        return res.status(404).json({ message: "Question not found " });
      }
      lesson.questions.splice(questionIndex, 1);
      await section.save();
      await Question.findByIdAndDelete(questionId);
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
