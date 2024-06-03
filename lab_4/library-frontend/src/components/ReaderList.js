import React, { useEffect, useState } from "react";
import axios from "axios";

const ReaderList = () => {
  const [readers, setReaders] = useState([]);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState("name");

  useEffect(() => {
    const fetchReaders = async () => {
      try {
        const response = await axios.get(
          `http://localhost:5000/api/readers?search=${search}&sort=${sort}`
        );
        setReaders(response.data);
      } catch (error) {
        console.error("Error fetching readers:", error);
      }
    };
    fetchReaders();
  }, [search, sort]);

  return (
    <div className="items-container">
      <input
        type="text"
        placeholder="Search readers..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />
      <select value={sort} onChange={(e) => setSort(e.target.value)}>
        <option value="name">Name</option>
        <option value="registration_date">Registration Date</option>
      </select>
      <ul>
        {readers.map((reader) => (
          <li key={reader._id}>{reader.name}</li>
        ))}
      </ul>
    </div>
  );
};

export default ReaderList;
