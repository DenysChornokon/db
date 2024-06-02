import React, { useEffect, useState } from "react";
import api from "../api"; // Імпортуйте api конфігурацію

const LoanList = () => {
  const [loans, setLoans] = useState([]);

  useEffect(() => {
    const fetchLoans = async () => {
      try {
        const response = await api.get("/api/loans"); // Використовуйте api з правильним базовим URL
        setLoans(response.data);
      } catch (error) {
        console.error("Error fetching loans:", error);
      }
    };
    fetchLoans();
  }, []);

  return (
    <div>
      <h2>Loans</h2>
      <ul>
        {loans.map((loan) => (
          <li key={loan._id}>
            Book ID: {loan.book_id}, Reader ID: {loan.reader_id}, Loan Date:{" "}
            {loan.loan_date}, Return Date: {loan.return_date}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default LoanList;
