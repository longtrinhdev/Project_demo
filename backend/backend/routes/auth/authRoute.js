const authController = require("../../controllers/auth/authController");
const middleware = require("../../middleware/middleware");
const router = require("express").Router();

router.post("/register", authController.registerUser);
router.post("/signin", authController.signInUser);
router.post("/checkUser", authController.checkEmail);
router.post("/fg_pass", authController.forgotPassword);
router.post("/changePW", middleware.verifyToken, authController.changePassword);
router.post("/requestToken", authController.requestNewToken);
router.post("/logout", middleware.verifyToken, authController.logoutUser);
router.get("/search", middleware.verifyToken, authController.searchFriendly);
router.get("/order", middleware.verifyToken, authController.orderUserByScore);
router.post("/google", authController.signInGoogleUser);

// export
module.exports = router;
