const express = require("express");
const router = express.Router();
const Loan = require("../models/Loan");

// Helper function to format dates
const formatDate = (date) => {
  if (!date) return null;
  return date.toISOString().split('T')[0];
}

// Get all loans
router.get("/", async (req, res) => {
  try {
    const loans = await Loan.find().populate("book_id").populate("reader_id");
    const formattedLoans = loans.map(loan => ({
      _id: loan._id,
      book: loan.book_id.title,  // Using populated book title
      reader: loan.reader_id.name,  // Using populated reader name
      loan_date: formatDate(loan.loan_date),
      return_date: formatDate(loan.return_date),
    }));
    res.json(formattedLoans);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create a new loan
router.post("/", async (req, res) => {
  const loan = new Loan({
    book_id: req.body.book_id,
    reader_id: req.body.reader_id,
    loan_date: req.body.loan_date,
    return_date: req.body.return_date
  });

  try {
    const newLoan = await loan.save();
    const populatedLoan = await Loan.findById(newLoan._id).populate("book_id").populate("reader_id");
    res.status(201).json({
      _id: populatedLoan._id,
      book: populatedLoan.book_id.title,
      reader: populatedLoan.reader_id.name,
      loan_date: formatDate(populatedLoan.loan_date),
      return_date: formatDate(populatedLoan.return_date),
    });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Get a specific loan
router.get("/:id", getLoan, (req, res) => {
  res.json({
    _id: res.loan._id,
    book: res.loan.book_id.title,
    reader: res.loan.reader_id.name,
    loan_date: formatDate(res.loan.loan_date),
    return_date: formatDate(res.loan.return_date),
  });
});

// Update a loan
router.patch("/:id", getLoan, async (req, res) => {
  if (req.body.book_id != null) {
    res.loan.book_id = req.body.book_id;
  }
  if (req.body.reader_id != null) {
    res.loan.reader_id = req.body.reader_id;
  }
  if (req.body.loan_date != null) {
    res.loan.loan_date = req.body.loan_date;
  }
  if (req.body.return_date != null) {
    res.loan.return_date = req.body.return_date;
  }

  try {
    const updatedLoan = await res.loan.save();
    const populatedLoan = await Loan.findById(updatedLoan._id).populate("book_id").populate("reader_id");
    res.json({
      _id: populatedLoan._id,
      book: populatedLoan.book_id.title,
      reader: populatedLoan.reader_id.name,
      loan_date: formatDate(populatedLoan.loan_date),
      return_date: formatDate(populatedLoan.return_date),
    });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Delete a loan
router.delete("/:id", getLoan, async (req, res) => {
  try {
    await res.loan.remove();
    res.json({ message: "Deleted Loan" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

async function getLoan(req, res, next) {
  let loan;
  try {
    loan = await Loan.findById(req.params.id).populate("book_id").populate("reader_id");
    if (loan == null) {
      return res.status(404).json({ message: "Cannot find loan" });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }

  res.loan = loan;
  next();
}

module.exports = router;
