const express = require("express");
const router = express.Router();
const Book = require("../models/Book");

// Get all books with search, sort, and filter
router.get("/", async (req, res) => {
  try {
    const { search, sort, filter } = req.query;
    let query = {};
    if (search) {
      query.$or = [
        { title: { $regex: search, $options: "i" } },
        { author: { $regex: search, $options: "i" } },
      ];
    }
    if (filter) {
      query.genre = filter;
    }
    const books = await Book.find(query).sort({ [sort]: 1 });
    res.json(books);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
