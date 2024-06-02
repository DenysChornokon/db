-- Active: 1711023372565@@127.0.0.1@5432@library
-- Процедури

-- Процедура для додавання нової книги
CREATE OR REPLACE PROCEDURE add_book(
    p_title VARCHAR,
    p_author VARCHAR,
    p_genre VARCHAR,
    p_publication_year INT,
    p_pages INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO books (title, author, genre, publication_year, pages)
    VALUES (p_title, p_author, p_genre, p_publication_year, p_pages);
END;
$$;

-- Перевірка процедури add_book
CALL add_book ( 'New Book', 'New Author', 'New Genre', 2024, 321 );

SELECT * FROM books WHERE title = 'New Book';

-- Процедура для оновлення інформації про читача
CREATE OR REPLACE PROCEDURE update_reader(
    p_reader_id INT,
    p_name VARCHAR,
    p_address VARCHAR,
    p_phone_number VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE readers
    SET name = p_name, address = p_address, phone_number = p_phone_number
    WHERE id = p_reader_id;
END;
$$;

-- Перевірка процедури update_reader
CALL update_reader (
    3,
    'John Doe Updated',
    '456 New Address',
    '987-654-3210'
);

SELECT * FROM readers WHERE id = 3;

-- Процедура для видалення позики
CREATE OR REPLACE PROCEDURE delete_loan(
    p_loan_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM loans WHERE id = p_loan_id;
END;
$$;

-- Перевірка процедури delete_loan
CALL delete_loan (3);

SELECT * FROM loans WHERE id = 3;

-- Функції

-- Функція для пошуку читачів за ім'ям
CREATE OR REPLACE FUNCTION find_readers_by_name(p_name VARCHAR)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    address VARCHAR,
    phone_number VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT readers.id, readers.name, readers.address, readers.phone_number
    FROM readers
    WHERE readers.name ILIKE '%' || p_name || '%';
END;
$$ LANGUAGE plpgsql;

-- Перевірка функції find_readers_by_name
SELECT * FROM find_readers_by_name ('Петро Петров');

-- Функція для пошуку книг за автором
CREATE OR REPLACE FUNCTION find_books_by_author(p_author VARCHAR)
RETURNS TABLE (
    id INT,
    title VARCHAR,
    author VARCHAR,
    genre VARCHAR,
    publication_year INT,
    pages INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT books.id, books.title, books.author, books.genre, books.publication_year, books.pages
    FROM books
    WHERE books.author ILIKE '%' || p_author || '%';
END;
$$ LANGUAGE plpgsql;

-- Перевірка функції find_books_by_author
SELECT * FROM find_books_by_author ('Тарас Шевченко');

-- Функція для підрахунку кількості книг у певному жанрі
CREATE OR REPLACE FUNCTION count_books_by_genre(p_genre VARCHAR)
RETURNS INT AS $$
DECLARE
    book_count INT;
BEGIN
    SELECT COUNT(*) INTO book_count
    FROM books
    WHERE genre ILIKE '%' || p_genre || '%';
    
    RETURN book_count;
END;
$$ LANGUAGE plpgsql;

-- Перевірка функції count_books_by_genre
SELECT count_books_by_genre ('поезія');

-- Тригери

-- Тригер для оновлення кількості доступних книг після додавання нової позики
CREATE OR REPLACE FUNCTION update_book_count_on_loan()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE books
    SET available_copies = available_copies - 1
    WHERE id = NEW.book_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_book_count_on_loan
AFTER INSERT ON loans FOR EACH ROW
EXECUTE FUNCTION update_book_count_on_loan ();

-- Перевірка тригера update_book_count_on_loan
-- Вставляємо нову позику і перевіряємо кількість доступних копій книги
INSERT INTO
    loans (book_id, reader_id, loan_date)
VALUES (1, 1, CURRENT_DATE);

SELECT available_copies FROM books WHERE id = 1;

-- Тригер для перевірки доступності книги перед додаванням нової позики
CREATE OR REPLACE FUNCTION check_book_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM loans WHERE book_id = NEW.book_id AND return_date IS NULL) > 0 THEN
        RAISE EXCEPTION 'The book is currently loaned out and not available.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_book_availability BEFORE INSERT ON loans FOR EACH ROW
EXECUTE FUNCTION check_book_availability ();


-- Тригер для автоматичного оновлення поля return_date до поточної дати при видаленні позики, якщо воно ще не встановлено
CREATE OR REPLACE FUNCTION set_return_date_on_delete()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.return_date IS NULL THEN
        UPDATE loans
        SET return_date = CURRENT_DATE
        WHERE id = OLD.id;
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_return_date_on_delete BEFORE DELETE ON loans FOR EACH ROW
EXECUTE FUNCTION set_return_date_on_delete ();

-- Перевірка тригера set_return_date_on_delete
-- Видаляємо позику і перевіряємо, чи оновилося поле return_date
DELETE FROM loans WHERE id = 3;

SELECT return_date FROM loans WHERE id = 2;

-- Транзакції

-- Транзакція для додавання нової книги разом із автором і жанром
BEGIN;

-- Додавання нового автора, якщо він ще не існує
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM authors WHERE name = 'Новий Автор') THEN
        INSERT INTO authors (name) VALUES ('Новий Автор');
    END IF;
END;
$$;

-- Додавання нового жанру, якщо він ще не існує
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM bookgenres WHERE genre = 'Новий Жанр') THEN
        INSERT INTO bookgenres (genre) VALUES ('Новий Жанр');
    END IF;
END;
$$;

-- Додавання нової книги
INSERT INTO
    books (
        title,
        author,
        genre,
        publication_year,
        pages
    )
VALUES (
        'Нова Книга',
        'Новий Автор',
        'Новий Жанр',
        2024,
        123
    );

COMMIT;

-- Перевірка транзакції для додавання нової книги
SELECT * FROM books WHERE title = 'Нова Книга';

-- Транзакція для оновлення інформації про книгу та відповідну позику
BEGIN;

-- Оновлення інформації про книгу
UPDATE books
SET
    title = 'Оновлена Книга',
    publication_year = 2023
WHERE
    id = 1;

-- Оновлення інформації про позику, пов'язану з цією книгою
UPDATE loans
SET
    return_date = '2024-06-30'
WHERE
    book_id = 1
    AND return_date IS NULL;

COMMIT;

-- Перевірка транзакції для оновлення інформації про книгу та відповідну позику
SELECT * FROM books WHERE id = 1;

SELECT * FROM loans WHERE book_id = 1;

-- Транзакція для видалення читача та всіх його позик
BEGIN;

-- Видалення всіх позик читача
DELETE FROM loans WHERE reader_id = 1;

-- Видалення читача
DELETE FROM readers WHERE id = 1;

COMMIT;

-- Перевірка транзакції для видалення читача та всіх його позик
SELECT * FROM readers WHERE id = 1;

SELECT * FROM loans WHERE reader_id = 1;