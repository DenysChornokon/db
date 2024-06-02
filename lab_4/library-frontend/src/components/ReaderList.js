import React, { useEffect, useState } from "react";
import api from "../api"; // Імпортуйте api конфігурацію

const ReaderList = () => {
  const [readers, setReaders] = useState([]);

  useEffect(() => {
    const fetchReaders = async () => {
      try {
        const response = await api.get("/api/readers"); // Використовуйте api з правильним базовим URL
        setReaders(response.data);
      } catch (error) {
        console.error("Error fetching readers:", error);
      }
    };
    fetchReaders();
  }, []);

  return (
    <div>
      <h2>Readers</h2>
      <ul>
        {readers.map((reader) => (
          <li key={reader._id}>
            {reader.name}, ({reader.address}, {reader.phone_number})
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ReaderList;
