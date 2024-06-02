const express = require("express");
const router = express.Router();
const Loan = require("../models/Loan");
const Book = require("../models/Book");
const Reader = require("../models/Reader");

// Get all loans with populated book and reader details
router.get("/", async (req, res) => {
  try {
    const loans = await Loan.aggregate([
      {
        $lookup: {
          from: "books",
          localField: "book_id",
          foreignField: "_id",
          as: "book",
        },
      },
      {
        $lookup: {
          from: "readers",
          localField: "reader_id",
          foreignField: "_id",
          as: "reader",
        },
      },
      {
        $unwind: "$book",
      },
      {
        $unwind: "$reader",
      },
    ]);

    res.json(loans);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Other routes remain the same

module.exports = router;
