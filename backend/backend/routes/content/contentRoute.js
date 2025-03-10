const contentChapterController = require("../../controllers/content/contentController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post(
  "/add",
  middleware.verifyToken,
  contentChapterController.addContent
);
router.get(
  "/all/:id",
  middleware.verifyToken,
  contentChapterController.getAllContent
);
router.put(
  "/:id",
  middleware.verifyToken,
  contentChapterController.updateContent
);
router.delete(
  "/:id",
  middleware.verifyToken,
  contentChapterController.deleteContent
);

// export
module.exports = router;
