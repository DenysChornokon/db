const express = require("express");
const router = express.Router();
const Reader = require("../models/Reader");

// Get all readers
router.get("/", async (req, res) => {
  try {
    const readers = await Reader.find();
    res.json(readers);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create a new reader
router.post("/", async (req, res) => {
  const reader = new Reader({
    name: req.body.name,
    address: req.body.address,
    phone_number: req.body.phone_number,
  });

  try {
    const newReader = await reader.save();
    res.status(201).json(newReader);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Get a specific reader
router.get("/:id", getReader, (req, res) => {
  res.json(res.reader);
});

// Update a reader
router.patch("/:id", getReader, async (req, res) => {
  if (req.body.name != null) {
    res.reader.name = req.body.name;
  }
  if (req.body.address != null) {
    res.reader.address = req.body.address;
  }
  if (req.body.phone_number != null) {
    res.reader.phone_number = req.body.phone_number;
  }

  try {
    const updatedReader = await res.reader.save();
    res.json(updatedReader);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Delete a reader
router.delete("/:id", getReader, async (req, res) => {
  try {
    await res.reader.remove();
    res.json({ message: "Deleted Reader" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

async function getReader(req, res, next) {
  let reader;
  try {
    reader = await Reader.findById(req.params.id);
    if (reader == null) {
      return res.status(404).json({ message: "Cannot find reader" });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }

  res.reader = reader;
  next();
}

module.exports = router;
