import React, { useEffect, useState } from "react";
import axios from "axios";

const LoanList = () => {
  const [loans, setLoans] = useState([]);

  useEffect(() => {
    const fetchLoans = async () => {
      try {
        const response = await axios.get("http://localhost:5000/api/loans");
        setLoans(response.data);
      } catch (error) {
        console.error("Error fetching loans:", error);
      }
    };
    fetchLoans();
  }, []);

  return (
    <div className="items-container">
      <ul>
        {loans.map((loan) => (
          <li key={loan._id}>
            Book: {loan.book}, Reader: {loan.reader}, Loan Date:{" "}
            {loan.loan_date}, Return Date: {loan.return_date}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default LoanList;
