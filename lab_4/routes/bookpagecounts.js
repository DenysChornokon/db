const express = require("express");
const router = express.Router();
const BookPageCount = require("../models/BookPageCount");

// Get all book page counts
router.get("/", async (req, res) => {
  try {
    const bookPageCounts = await BookPageCount.find();
    res.json(bookPageCounts);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create a new book page count
router.post("/", async (req, res) => {
  const bookPageCount = new BookPageCount({
    pagecountrange: req.body.pagecountrange,
  });

  try {
    const newBookPageCount = await bookPageCount.save();
    res.status(201).json(newBookPageCount);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Get a specific book page count
router.get("/:id", getBookPageCount, (req, res) => {
  res.json(res.bookPageCount);
});

// Update a book page count
router.patch("/:id", getBookPageCount, async (req, res) => {
  if (req.body.pagecountrange != null) {
    res.bookPageCount.pagecountrange = req.body.pagecountrange;
  }

  try {
    const updatedBookPageCount = await res.bookPageCount.save();
    res.json(updatedBookPageCount);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Delete a book page count
router.delete("/:id", getBookPageCount, async (req, res) => {
  try {
    await res.bookPageCount.remove();
    res.json({ message: "Deleted BookPageCount" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

async function getBookPageCount(req, res, next) {
  let bookPageCount;
  try {
    bookPageCount = await BookPageCount.findById(req.params.id);
    if (bookPageCount == null) {
      return res.status(404).json({ message: "Cannot find book page count" });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }

  res.bookPageCount = bookPageCount;
  next();
}

module.exports = router;
