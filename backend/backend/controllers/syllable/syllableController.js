const Syllable = require("../../models/syllable/syllable");
const Course = require("../../models/course/course");

const syllableController = {
  // ? add vowel
  addVowel: async (req, res) => {
    try {
      const newSyllable = new Syllable(req.body);
      const saveSyllable = await newSyllable.save();
      await Course.findByIdAndUpdate(req.body.courseId, {
        $push: { vowelIds: saveSyllable._id },
      });
      return res.status(200).json({ message: "Add vowel successfully! " });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? add consonant
  addConsonant: async (req, res) => {
    try {
      const newSyllable = new Syllable(req.body);
      const saveSyllable = await newSyllable.save();
      await Course.findByIdAndUpdate(req.body.courseId, {
        $push: { consonantIds: saveSyllable._id },
      });
      return res.status(200).json({ message: "Add consonant successfully! " });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?get all vowel by course id
  getAllVowelsByCourseId: async (req, res) => {
    try {
      const course = await Course.findById(req.params.id);
      if (!course) {
        return res.status(404).json({ message: "Course not found" });
      }
      const vowels = await Syllable.find({ _id: { $in: course.vowelIds } });
      return res.status(200).json(vowels);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?get all consonant by course id
  getAllConsonantByCourseId: async (req, res) => {
    try {
      const course = await Course.findById(req.params.id);
      if (!course) {
        return res.status(404).json({ message: "Course not found" });
      }
      const consonants = await Syllable.find({
        _id: { $in: course.consonantIds },
      });
      return res.status(200).json(consonants);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?get syllable by id
  getSyllableById: async (req, res) => {
    try {
      const syllable = await Syllable.findById(req.params.id);
      if (!syllable) {
        return res.status(404).json({ message: "Syllable not found" });
      }
      return res.status(200).json(syllable);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ? update syllable by id
  updateSyllableById: async (req, res) => {
    try {
      const syllable = await Syllable.findByIdAndUpdate(
        req.params.id,
        req.body,
        {
          new: true,
        }
      );
      if (!syllable) {
        return res.status(404).json({ message: "Syllable not found" });
      }
      return res.status(200).json(syllable);
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?delete vowel by id
  deleteVowelById: async (req, res) => {
    try {
      const syllable = await Syllable.findByIdAndDelete(req.params.id);
      if (!syllable) {
        return res.status(404).json({ message: "Syllable not found" });
      }
      await Course.findByIdAndUpdate(syllable.courseId, {
        $pull: { vowelIds: req.params.id },
      });
      return res.status(200).json({ message: "Delete vowel successfully!" });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },

  // ?delete consonant by id
  deleteConsonantById: async (req, res) => {
    try {
      const syllable = await Syllable.findByIdAndDelete(req.params.id);
      if (!syllable) {
        return res.status(404).json({ message: "Syllable not found" });
      }
      await Course.findByIdAndUpdate(syllable.courseId, {
        $pull: { consonantIds: req.params.id },
      });
      return res
        .status(200)
        .json({ message: "Delete consonant successfully!" });
    } catch (error) {
      return res.status(500).json({ message: "Internal Server Error" });
    }
  },
};

//export
module.exports = syllableController;
