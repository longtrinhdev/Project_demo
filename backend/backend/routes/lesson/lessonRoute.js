const lessonController = require("../../controllers/lesson/lessonController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post("/add", middleware.verifyToken, lessonController.addLesson);
router.get("/all/:id", middleware.verifyToken, lessonController.getAllLessons);
router.get("/:id", middleware.verifyToken, lessonController.getLessonById);
router.get("/:id", middleware.verifyToken, lessonController.getLessonById);
router.delete("/:id", middleware.verifyToken, lessonController.deleteLesson);

// export
module.exports = router;
