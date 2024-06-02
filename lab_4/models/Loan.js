const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const LoanSchema = new Schema({
  book_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Book",
    required: true,
  },
  reader_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Reader",
    required: true,
  },
  loan_date: {
    type: Date,
    required: true,
  },
  return_date: {
    type: Date,
  },
});

module.exports = mongoose.model("Loan", LoanSchema);
