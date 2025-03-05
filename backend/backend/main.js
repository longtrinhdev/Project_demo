const express = require("express");
const cookieParser = require("cookie-parser");
const dotenv = require("dotenv");
const cor = require("cors");
const mongoose = require("mongoose");
const authRoute = require("../backend/routes/auth/authRoute");
const courseRoute = require("../backend/routes/course/courseRoute");
const chapterRoute = require("../backend/routes/chapter/chapterRoute");
const contentChapterRoute = require("../backend/routes/content/contentRoute");
const lessonRoute = require("../backend/routes/lesson/lessonRoute");
const syllableRoute = require("../backend/routes/syllable/syllableRoute");
const questionRoute = require("../backend/routes/question/questionRoute");

const app = express();

dotenv.config();
mongoose.connect(process.env.MONGO_URL, () => {
  console.log("Connected to Database");
});

app.use(cor());
app.use(express.json());
app.use(cookieParser());

app.use("/api/v1/auth", authRoute);
app.use("/api/v1/course", courseRoute);
app.use("/api/v1/chapter", chapterRoute);
app.use("/api/v1/content", contentChapterRoute);
app.use("/api/v1/lesson", lessonRoute);
app.use("/api/v1/syllable", syllableRoute);
app.use("/api/v1/question", questionRoute);

app.listen(process.env.PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${process.env.PORT}`);
});
