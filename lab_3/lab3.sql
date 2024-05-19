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
    SELECT id, name, address, phone_number
    FROM readers
    WHERE name ILIKE '%' || p_name || '%';
END;
$$ LANGUAGE plpgsql;

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
    SELECT id, title, author, genre, publication_year, pages
    FROM books
    WHERE author ILIKE '%' || p_author || '%';
END;
$$ LANGUAGE plpgsql;

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


--Транзакції

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


-- Транзакція для видалення читача та всіх його позик

BEGIN;

-- Видалення всіх позик читача
DELETE FROM loans WHERE reader_id = 1;

-- Видалення читача
DELETE FROM readers WHERE id = 1;

COMMIT;