const express = require("express");
const router = express.Router();
const BookGenre = require("../models/BookGenre");

// Get all book genres
router.get("/", async (req, res) => {
  try {
    const bookGenres = await BookGenre.find();
    res.json(bookGenres);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create a new book genre
router.post("/", async (req, res) => {
  const bookGenre = new BookGenre({
    genre: req.body.genre,
  });

  try {
    const newBookGenre = await bookGenre.save();
    res.status(201).json(newBookGenre);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Get a specific book genre
router.get("/:id", getBookGenre, (req, res) => {
  res.json(res.bookGenre);
});

// Update a book genre
router.patch("/:id", getBookGenre, async (req, res) => {
  if (req.body.genre != null) {
    res.bookGenre.genre = req.body.genre;
  }

  try {
    const updatedBookGenre = await res.bookGenre.save();
    res.json(updatedBookGenre);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Delete a book genre
router.delete("/:id", getBookGenre, async (req, res) => {
  try {
    await res.bookGenre.remove();
    res.json({ message: "Deleted BookGenre" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

async function getBookGenre(req, res, next) {
  let bookGenre;
  try {
    bookGenre = await BookGenre.findById(req.params.id);
    if (bookGenre == null) {
      return res.status(404).json({ message: "Cannot find book genre" });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }

  res.bookGenre = bookGenre;
  next();
}

module.exports = router;
