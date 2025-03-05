const Course = require("../../models/course/course");
const User = require("../../models/user/user");

const courseController = {
  // ? add course
  addCourse: async (req, res) => {
    try {
      const newCourse = new Course(req.body);
      const saveCourse = await newCourse.save();
      await User.findByIdAndUpdate(req.body.userIds, {
        $push: { courseId: saveCourse._id },
      });

      return res.status(200).json({ message: "Add course successfully! " });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? get all courses
  getAllCourses: async (req, res) => {
    try {
      const courses = await Course.find();
      return res.status(200).json(courses);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? get course by id
  getCourseById: async (req, res) => {
    try {
      const course = await Course.findById(req.params.id);
      if (!course) {
        return res.status(404).json({ message: "Course not found!" });
      }
      return res.status(200).json(course);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? update course
  updateCourse: async (req, res) => {
    try {
      const course = await Course.findByIdAndUpdate(req.params.id, req.body, {
        new: true,
      });
      if (!course) {
        return res.status(404).json({ message: "Course not found!" });
      }
      return res.status(200).json(course);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? delete course
  deleteCourse: async (req, res) => {
    try {
      const course = await Course.findByIdAndDelete(req.params.id);
      if (!course) {
        return res.status(404).json({ message: "Course not found!" });
      }
      await User.findByIdAndUpdate(course.userIds, {
        $pull: { courseId: req.params.id },
      });
      return res.status(200).json({ message: "Delete course successfully!" });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },
};

// export
module.exports = courseController;
