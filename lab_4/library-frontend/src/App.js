import React from "react";
import { BrowserRouter as Router, Route, Routes, Link } from "react-router-dom";
import Home from "./pages/Home";
import Books from "./pages/Books";
import Readers from "./pages/Readers";
import Loans from "./pages/Loans";
import './App.css'

function App() {
  return (
    <Router>
      <div className="container">
        <nav>
          <ul>
            <div className="nav-links">
              <li className="home">
                <Link to="/">Home</Link>
              </li>
              <li>
                <Link to="/books">Books</Link>
              </li>
              <li>
                <Link to="/readers">Readers</Link>
              </li>
              <li>
                <Link to="/loans">Loans</Link>
              </li>
            </div>
          </ul>
        </nav>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/books" element={<Books />} />
          <Route path="/readers" element={<Readers />} />
          <Route path="/loans" element={<Loans />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
