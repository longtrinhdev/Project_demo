const questionController = require("../../controllers/question/questionController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post(
  "/add/lesson",
  middleware.verifyToken,
  questionController.addQuestionToLesson
);
router.post(
  "/add/syllable",
  middleware.verifyToken,
  questionController.addQuestionToSyllable
);
router.get(
  "/lesson/:id",
  middleware.verifyToken,
  questionController.getAllQuestionsByLessonId
);
router.get(
  "/syllable/:id",
  middleware.verifyToken,
  questionController.getAllQuestionsBySyllableId
);
router.get("/:id", middleware.verifyToken, questionController.getQuestionById);
router.put(
  "/:id",
  middleware.verifyToken,
  questionController.updateQuestionById
);
router.delete(
  "/lesson/:id",
  middleware.verifyToken,
  questionController.deleteQuestionByLessonId
);
router.delete(
  "/syllable/:id",
  middleware.verifyToken,
  questionController.deleteQuestionBySyllableId
);

// export
module.exports = router;
