const contentChapterController = require("../../controllers/content/contentController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post(
  "/add",
  middleware.verifyToken,
  contentChapterController.addContentChapter
);
router.get(
  "/all/:id",
  middleware.verifyToken,
  contentChapterController.getAllContentChapter
);
router.put(
  "/:id",
  middleware.verifyToken,
  contentChapterController.updateContentChapter
);
router.delete(
  "/:id",
  middleware.verifyToken,
  contentChapterController.deleteContentChapter
);

// export
module.exports = router;
