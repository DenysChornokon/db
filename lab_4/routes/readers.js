const express = require("express");
const router = express.Router();
const Reader = require("../models/Reader");

// Get all readers with search and sort
router.get("/", async (req, res) => {
  try {
    const { search, sort } = req.query;
    let query = {};
    if (search) {
      query.name = { $regex: search, $options: "i" };
    }
    const readers = await Reader.find(query).sort({ [sort]: 1 });
    res.json(readers);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
