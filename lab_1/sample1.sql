-- Active: 1711023372565@@127.0.0.1@5432@library@public
-- Створення нових користувачів

CREATE USER librarian WITH PASSWORD 'password';

CREATE USER reader WITH PASSWORD 'reader';

-- Надання прав доступу користувачам
GRANT ALL PRIVILEGES ON DATABASE library TO librarian;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader;

-- Створюємо таблицю 'readers'
CREATE TABLE readers (
    id SERIAL PRIMARY KEY, name VARCHAR(100), address VARCHAR(255), phone_number VARCHAR(15)
);

-- Створюємо таблицю 'books'
CREATE TABLE books (
    id SERIAL PRIMARY KEY, title VARCHAR(100), author VARCHAR(100), genre VARCHAR(50), publication_year INT, pages INT, pagecount_id INT REFERENCES bookpagecounts (id)
);

-- Створюємо таблицю 'loans'
CREATE TABLE loans (
    id SERIAL PRIMARY KEY, book_id INT REFERENCES books (id), reader_id INT REFERENCES readers (id), loan_date DATE, return_date DATE
);


CREATE TABLE bookgenres (
    id SERIAL PRIMARY KEY, genre VARCHAR(50) NOT NULL
);

CREATE TABLE bookpagecounts (
    id SERIAL PRIMARY KEY, pagecountrange VARCHAR(50) NOT NULL
);


CREATE TABLE authors (
    id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL
);

INSERT INTO authors (name)
SELECT DISTINCT author
FROM books;

INSERT INTO
    bookpagecounts (pagecountrange)
VALUES ('Більше 100 сторінок'),
    ('101 - 200 сторінок'),
    ('201 - 300 сторінок'),
    ('301 - 400 сторінок'),
    ('400+ сторінок');

INSERT INTO
    bookgenres (genre)
VALUES ('поезія'), 
    ('проза'), 
    ('драма'), 
    ('роман'), 
    ('сценарій'), 
   ('саморозвиток'), 
    ('філософія');


-- Заповнюємо таблицю 'readers'
INSERT INTO
    readers (name, address, phone_number)
VALUES (
        'Іван Іванов', 'вул. Лісова, 1, Київ', '+380501234567'
    ),
    (
        'Петро Петров', 'вул. Садова, 2, Львів', '+380501234568'
    ),
    (
        'Олег Олегов', 'вул. Паркова, 3, Одеса', '+380501234569'
    ),
    (
        'Микола Миколаєнко', 'вул. Житомирська, 4, Житомир', '+380501234570'
    ),
    (
        'Андрій Андрієнко', 'вул. Чернігівська, 5, Чернігів', '+380501234571'
    ),
    (
        'Сергій Сергієнко', 'вул. Сумська, 6, Суми', '+380501234572'
    ),
    (
        'Василь Василенко', 'вул. Полтавська, 7, Полтава', '+380501234573'
    ),
    (
        'Олександр Олександров', 'вул. Харківська, 8, Харків', '+380501234574'
    ),
    (
        'Юрій Юрієнко', 'вул. Дніпровська, 9, Дніпро', '+380501234575'
    ),
    (
        'Володимир Володимиров', 'вул. Запорізька, 10, Запоріжжя', '+380501234576'
    ),
    (
        'Богдан Богданов', 'вул. Луганська, 11, Луганськ', '+380501234577'
    ),
    (
        'Роман Романов', 'вул. Донецька, 12, Донецьк', '+380501234578'
    ),
    (
        'Тарас Тарасов', 'вул. Криворізька, 13, Кривий Ріг', '+380501234579'
    );


-- Заповнюємо таблицю 'books'
INSERT INTO
    books (
        title, author, genre, publication_year, pages
    )
VALUES (
        'Кобзар', 'Тарас Шевченко', 'поезія', 1840, 160
    ),
    (
        'Лісова пісня', 'Леся Українка', 'драма', 1911, 100
    ),
    (
        'Маруся Чурай', 'Ліна Костенко', 'поезія', 1980, 224
    ),
    (
        'Вій', 'Микола Гоголь', 'проза', 1835, 100
    ),
    (
        'Зачарована Десна', 'Микола Хвильовий', 'проза', 1957, 256
    ),
    (
        'Тигролови', 'Іван Багряний', 'роман', 1943, 300
    ),
    (
        'Собор на крові', 'Олесь Гончар', 'роман', 1972, 600
    ),
    (
        'Твори', 'Максим Рильський', 'поезія', 1960, 448
    ),
    (
        'Камінний хрест', 'Василь Стефаник', 'проза', 1900, 128
    ),
    (
        'Сонячний кларнет', 'Василь Симоненко', 'поезія', 1962, 96
    ),
    (
        'Повернення', 'Володимир Винниченко', 'роман', 1910, 352
    ),
    (
        'Земля', 'Олександр Довженко', 'сценарій', 1930, 80
    );
-- Заповнюємо таблицю 'loans'
INSERT INTO
    loans (
        book_id, reader_id, loan_date, return_date
    )
VALUES (
        1, 1, '2024-03-01', '2024-03-31'
    ),
    (2, 2, '2024-03-15', NULL),
    (
        3, 3, '2024-03-20', '2024-04-20'
    ),
    (
        1, 4, '2024-04-01', '2024-04-30'
    ),
    (2, 5, '2024-04-15', NULL),
    (
        3, 6, '2024-04-20', '2024-05-20'
    ),
    (
        1, 7, '2024-05-01', '2024-05-31'
    ),
    (2, 8, '2024-05-15', NULL),
    (
        3, 9, '2024-05-20', '2024-06-20'
    ),
    (
        1, 10, '2024-06-01', '2024-06-30'
    ),
    (2, 11, '2024-06-15', NULL),
    (
        3, 12, '2024-06-20', '2024-07-20'
    ),
    (
        1, 13, '2024-07-01', '2024-07-31'
    );

-- Оновлюємо таблицю 'books'
-- Оновлюємо таблицю 'books'
UPDATE books
SET
    pagecount_id = CASE
        WHEN pages <= 100 THEN (
            SELECT id
            FROM bookpagecounts
            WHERE
                pagecountrange = 'Більше 100 сторінок'
            LIMIT 1
        )
        WHEN pages BETWEEN 101 AND 200  THEN (
            SELECT id
            FROM bookpagecounts
            WHERE
                pagecountrange = '101 - 200 сторінок'
            LIMIT 1
        )
        WHEN pages BETWEEN 201 AND 300  THEN (
            SELECT id
            FROM bookpagecounts
            WHERE
                pagecountrange = '201 - 300 сторінок'
            LIMIT 1
        )
        WHEN pages BETWEEN 301 AND 400  THEN (
            SELECT id
            FROM bookpagecounts
            WHERE
                pagecountrange = '301 - 400 сторінок'
            LIMIT 1
        )
        ELSE (
            SELECT id
            FROM bookpagecounts
            WHERE
                pagecountrange = '400+ сторінок'
            LIMIT 1
        )
    END;

SELECT * FROM books;
SELECT * FROM readers;
SELECT * FROM loans;
SELECT * FROM bookgenres;
SELECT * FROM authors;
SELECT * FROM bookpagecounts;
