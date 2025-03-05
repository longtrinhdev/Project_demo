const courseController = require("../../controllers/course/courseController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post("/add", middleware.verifyToken, courseController.addCourse);
router.get("/all", courseController.getAllCourses);
router.get("/:id", courseController.getCourseById);
router.put("/:id", middleware.verifyToken, courseController.updateCourse);
router.delete("/:id", middleware.verifyToken, courseController.deleteCourse);

module.exports = router;
