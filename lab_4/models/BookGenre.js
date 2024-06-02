const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BookGenreSchema = new Schema({
  genre: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("BookGenre", BookGenreSchema);
