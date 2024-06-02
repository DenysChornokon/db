const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ReaderSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  phone_number: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("Reader", ReaderSchema);
