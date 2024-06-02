const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BookPageCountSchema = new Schema({
  pagecountrange: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("BookPageCount", BookPageCountSchema);
