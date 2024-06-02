const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BookSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  genre: {
    type: String,
    required: true,
  },
  publication_year: {
    type: Number,
    required: true,
  },
  pages: {
    type: Number,
    required: true,
  },
  pagecount_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "BookPageCount",
  },
});

module.exports = mongoose.model("Book", BookSchema);
