const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();

// Middleware
app.use(bodyParser.json());
app.use(cors());

// DB Config
const db = require("./config").url;

// Connect to MongoDB
mongoose
  .connect(db, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.log(err));

// Define Routes
app.use("/api/readers", require("./routes/readers"));
app.use("/api/books", require("./routes/books"));
app.use("/api/loans", require("./routes/loans"));
app.use("/api/bookgenres", require("./routes/bookgenres"));
app.use("/api/authors", require("./routes/authors"));
app.use("/api/bookpagecounts", require("./routes/bookpagecounts"));

const port = process.env.PORT || 5000;

app.listen(port, () => console.log(`Server started on port ${port}`));
