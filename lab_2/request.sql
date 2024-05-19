-- 1. Вибрати всіх читачів
SELECT * FROM readers;

-- 2. Вибрати всі книги
SELECT * FROM books;

-- 3. Вибрати всі позики
SELECT * FROM loans;

-- 4. Вибрати всі книги, які зараз позичені
SELECT b.title, b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    l.return_date IS NULL;

-- 5. Вибрати всіх читачів, які мають позики
SELECT r.name FROM readers r JOIN loans l ON r.id = l.reader_id;

-- 6. Вибрати всі книги, які були позичені Іваном Івановим
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
    JOIN readers r ON l.reader_id = r.id
WHERE
    r.name = 'Іван Іванов';

-- 7. Вибрати всі книги, які були позичені в 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024;

-- 8. Вибрати назву книги, яку найчастіше позичали
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 9. Вибрати читача, який позичив найбільше книг
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
GROUP BY
    r.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 10. Вибрати автора, чиї книги найчастіше позичали
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 11. Вибрати всі книги, які були позичені і повернуті в 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
    AND EXTRACT(
        YEAR
        FROM l.return_date
    ) = 2024;

-- 12. Вибрати читача, який позичив найменше книг
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
GROUP BY
    r.name
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 13. Вибрати книгу, яку найменше позичали
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 14. Вибрати всі книги, які не були позичені
SELECT b.title
FROM books b
    LEFT JOIN loans l ON b.id = l.book_id
WHERE
    l.book_id IS NULL;

-- 15. Вибрати всіх читачів, які не мають позики
SELECT r.name
FROM readers r
    LEFT JOIN loans l ON r.id = l.reader_id
WHERE
    l.reader_id IS NULL;

-- 16. Вибрати книгу, яка була позичена найраніше
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
ORDER BY l.loan_date ASC
LIMIT 1;

-- 18. Вибрати читача, який позичив найбільше книг у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 19. Вибрати жанр, який найпопулярніший серед позичених книг
SELECT b.genre
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 20. Вибрати автора, чиї книги позичали найбільше різних читачів
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
    JOIN readers r ON l.reader_id = r.id
GROUP BY
    b.author
ORDER BY COUNT(DISTINCT r.id) DESC
LIMIT 1;

-- 21. Вибрати книгу, яка була позичена найпізніше
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
ORDER BY l.loan_date DESC
LIMIT 1;

-- 22. Вибрати читача, який має найбільше активних позик (позики, які ще не повернуті)
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
WHERE
    l.return_date IS NULL
GROUP BY
    r.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 23. Вибрати книгу, яка була позичена найбільше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 24. Вибрати читача, який позичив книги найбільшої кількості різних авторів
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name
ORDER BY COUNT(DISTINCT b.author) DESC
LIMIT 1;

-- 25. Вибрати всі книги, які були позичені більше ніж один раз
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title
HAVING
    COUNT(*) > 1;

-- 26. Вибрати читача, який позичив найбільше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 27. Вибрати книгу, яка була позичена найбільше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 28. Вибрати читача, який позичив книги найбільшої кількості різних авторів
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name
ORDER BY COUNT(DISTINCT b.author) DESC
LIMIT 1;

-- 29. Вибрати книгу, яка була позичена найпізніше
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
ORDER BY l.loan_date DESC
LIMIT 1;

-- 30. Вибрати читача, який має найбільше активних позик (позики, які ще не повернуті)
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
WHERE
    l.return_date IS NULL
GROUP BY
    r.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 31. Вибрати книгу, яка була позичена найбільше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 32. Вибрати читача, який позичив книги найбільшої кількості різних авторів
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name
ORDER BY COUNT(DISTINCT b.author) DESC
LIMIT 1;

-- 33. Вибрати книгу, яка була позичена найпізніше
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
ORDER BY l.loan_date DESC
LIMIT 1;

-- 34. Вибрати читача, який має найбільше активних позик (позики, які ще не повернуті)
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
WHERE
    l.return_date IS NULL
GROUP BY
    r.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 35. Вибрати читача, який позичив найбільше книг одного жанру
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 36. Вибрати книгу, яка була позичена найменше разів
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 37. Вибрати автора, чиї книги були позичені найменше разів
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 38. Вибрати жанр, який найменш популярний серед позичених книг
SELECT b.genre
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 39. Вибрати читача, який позичив найменше книг у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 40. Вибрати книгу, яка була позичена найбільше разів одним читачем
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 41. Вибрати читача, який позичив найбільше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 42. Вибрати автора, чиї книги були позичені найбільше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 43. Вибрати книгу, яка була позичена найменше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 44. Вибрати читача, який позичив найменше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 45. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 46. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 47. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 48. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 49. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 50. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 51. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 52. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 53. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 54. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 55. Вибрати читача, який позичив найбільше книг одного жанру
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 56. Вибрати книгу, яка була позичена найменше разів
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 57. Вибрати автора, чиї книги були позичені найменше разів
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 58. Вибрати жанр, який найменш популярний серед позичених книг
SELECT b.genre
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 59. Вибрати читача, який позичив найменше книг у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 60. Вибрати книгу, яка була позичена найбільше разів одним читачем
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 61. Вибрати читача, який позичив найбільше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 62. Вибрати автора, чиї книги були позичені найбільше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 63. Вибрати книгу, яка була позичена найменше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 64. Вибрати читача, який позичив найменше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 65. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 66. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 67. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 68. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 69. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 70. Вибрати жанр, який був найменш популярний серед позичених книг у 2024 році
SELECT b.genre
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 71. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 72. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 73. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 74. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 75. Вибрати книгу, яка була позичена найбільше разів одним читачем
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 76. Вибрати читача, який позичив найбільше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 77. Вибрати автора, чиї книги були позичені найбільше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 78. Вибрати книгу, яка була позичена найменше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 79. Вибрати читача, який позичив найменше книг одного автора
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
GROUP BY
    r.name,
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 80. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 81. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 82. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 83. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 84. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 85. Вибрати книгу, яка була позичена найбільше разів у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 86. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 87. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 88. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 89. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 90. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 91. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 92. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 93. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 94. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 95. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 96. Вибрати читача, який позичив найменше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 97. Вибрати автора, чиї книги були позичені найменше разів у 2024 році
SELECT b.author
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.author
ORDER BY COUNT(*) ASC
LIMIT 1;

-- 98. Вибрати книгу, яка була позичена найбільше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 99. Вибрати читача, який позичив найбільше книг одного жанру у 2024 році
SELECT r.name
FROM readers r
    JOIN loans l ON r.id = l.reader_id
    JOIN books b ON l.book_id = b.id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    r.name,
    b.genre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 100. Вибрати книгу, яка була позичена найменше разів одним читачем у 2024 році
SELECT b.title
FROM books b
    JOIN loans l ON b.id = l.book_id
WHERE
    EXTRACT(
        YEAR
        FROM l.loan_date
    ) = 2024
GROUP BY
    b.title,
    l.reader_id
ORDER BY COUNT(*) ASC
LIMIT 1;

SELECT COUNT(*) FROM loans
WHERE loan_date BETWEEN '2024-01-01' AND '2024-05-31'








