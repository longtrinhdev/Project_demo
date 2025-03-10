const sectionController = require("../../controllers/section/sectionController");
const middleware = require("../../middleware/middleware");
const route = require("express").Router();

route.post("/add", middleware.verifyToken, sectionController.addSection);
route.get("/:id", middleware.verifyToken, sectionController.getAllSections);
route.put("/:id", middleware.verifyToken, sectionController.updateSection);
route.delete("/:id", middleware.verifyToken, sectionController.deleteSection);

module.exports = route;
