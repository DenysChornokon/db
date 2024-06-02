const mongoose = require("mongoose");

const dbUrl = "mongodb://127.0.0.1:27017/library";

module.exports = {
  url: dbUrl,
};

mongoose.connect(dbUrl);
