const chapterController = require("../../controllers/chapter/chapterController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post("/add", middleware.verifyToken, chapterController.addChapter);
router.get(
  "/all/:id",
  middleware.verifyToken,
  chapterController.getAllChapters
);
router.get("/:id", middleware.verifyToken, chapterController.getChapterById);
router.put("/:id", middleware.verifyToken, chapterController.updateChapter);
router.delete("/:id", middleware.verifyToken, chapterController.deleteChapter);

//export
module.exports = router;
