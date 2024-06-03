import React, { useEffect, useState } from "react";
import axios from "axios";

const BookList = () => {
  const [books, setBooks] = useState([]);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState("title");
  const [filter, setFilter] = useState("");

  useEffect(() => {
    const fetchBooks = async () => {
      try {
        const response = await axios.get(
          `http://localhost:5000/api/books?search=${search}&sort=${sort}&filter=${filter}`
        );
        setBooks(response.data);
      } catch (error) {
        console.error("Error fetching books:", error);
      }
    };
    fetchBooks();
  }, [search, sort, filter]);

  return (
    <div className="items-container">
      <input
        type="text"
        placeholder="Search books..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />
      <select value={sort} onChange={(e) => setSort(e.target.value)}>
        <option value="title">Title</option>
        <option value="author">Author</option>
        <option value="publication_year">Year</option>
      </select>
      <select value={filter} onChange={(e) => setFilter(e.target.value)}>
        <option value="">All Genres</option>
        <option value="поезія">поезія</option>
        <option value="драма">драма</option>
        <option value="проза">проза</option>
        <option value="сценарій">сценарій</option>
      </select>
      <ul>
        {books.map((book) => (
          <li key={book._id}>
            {book.title} - {book.author}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default BookList;
