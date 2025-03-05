const syllableController = require("../../controllers/syllable/syllableController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post("/vowel", middleware.verifyToken, syllableController.addVowel);
router.post(
  "/consonant",
  middleware.verifyToken,
  syllableController.addConsonant
);
router.get(
  "/vowel/:id",
  middleware.verifyToken,
  syllableController.getAllVowelsByCourseId
);
router.get(
  "/consonant/:id",
  middleware.verifyToken,
  syllableController.getAllConsonantByCourseId
);
router.get("/:id", middleware.verifyToken, syllableController.getSyllableById);
router.put(
  "/:id",
  middleware.verifyToken,
  syllableController.updateSyllableById
);
router.delete(
  "/vowel/:id",
  middleware.verifyToken,
  syllableController.deleteVowelById
);
router.delete(
  "/consonant/:id",
  middleware.verifyToken,
  syllableController.deleteConsonantById
);

// export
module.exports = router;
