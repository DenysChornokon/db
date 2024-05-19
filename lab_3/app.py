from flask import Flask, request, jsonify
import psycopg2
import psycopg2.extras

app = Flask(__name__)

# Підключення до PostgreSQL
conn = psycopg2.connect(
    dbname="library",
    user="postgres",
    password="admin",
    host="127.0.0.1",
    options="-c client_encoding=UTF8"
)
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

# Створення нового читача


@app.route('/reader', methods=['POST'])
def create_reader():
    data = request.json
    name = data['name']
    address = data['address']
    phone_number = data['phone_number']
    cur.execute("CALL add_reader(%s, %s, %s)", (name, address, phone_number))
    conn.commit()
    return jsonify({"message": "Reader created successfully"}), 201

# Отримання інформації про всіх читачів


@app.route('/reader', methods=['GET'])
def get_all_readers():
    cur.execute("SELECT * FROM readers")
    readers = cur.fetchall()
    return jsonify([dict(reader) for reader in readers])

# Отримання інформації про конкретного читача за його ідентифікатором


@app.route('/reader/<int:reader_id>', methods=['GET'])
def get_reader_by_id(reader_id):
    cur.execute("SELECT * FROM readers WHERE id = %s", (reader_id,))
    reader = cur.fetchone()
    if reader:
        return jsonify(dict(reader))
    else:
        return jsonify({"message": "Reader not found"}), 404

# Оновлення інформації про читача


@app.route('/reader/<int:reader_id>', methods=['PUT'])
def update_reader(reader_id):
    data = request.json
    name = data['name']
    address = data['address']
    phone_number = data['phone_number']
    cur.execute("CALL update_reader(%s, %s, %s, %s)",
                (reader_id, name, address, phone_number))
    conn.commit()
    return jsonify({"message": "Reader updated successfully"})

# Видалення читача за його ідентифікатором


@app.route('/reader/<int:reader_id>', methods=['DELETE'])
def delete_reader(reader_id):
    cur.execute("DELETE FROM readers WHERE id = %s", (reader_id,))
    conn.commit()
    return jsonify({"message": "Reader deleted successfully"})

# Створення нової книги


@app.route('/book', methods=['POST'])
def create_book():
    data = request.json
    title = data['title']
    author = data['author']
    genre = data['genre']
    publication_year = data['publication_year']
    pages = data['pages']
    cur.execute("CALL add_book(%s, %s, %s, %s, %s)",
                (title, author, genre, publication_year, pages))
    conn.commit()
    return jsonify({"message": "Book created successfully"}), 201

# Отримання інформації про всі книги


@app.route('/book', methods=['GET'])
def get_all_books():
    cur.execute("SELECT * FROM books")
    books = cur.fetchall()
    return jsonify([dict(book) for book in books])

# Отримання інформації про конкретну книгу за її ідентифікатором


@app.route('/book/<int:book_id>', methods=['GET'])
def get_book_by_id(book_id):
    cur.execute("SELECT * FROM books WHERE id = %s", (book_id,))
    book = cur.fetchone()
    if book:
        return jsonify(dict(book))
    else:
        return jsonify({"message": "Book not found"}), 404

# Оновлення інформації про книгу


@app.route('/book/<int:book_id>', methods=['PUT'])
def update_book(book_id):
    data = request.json
    title = data['title']
    author = data['author']
    genre = data['genre']
    publication_year = data['publication_year']
    pages = data['pages']
    cur.execute("UPDATE books SET title = %s, author = %s, genre = %s, publication_year = %s, pages = %s WHERE id = %s",
                (title, author, genre, publication_year, pages, book_id))
    conn.commit()
    return jsonify({"message": "Book updated successfully"})

# Видалення книги за її ідентифікатором


@app.route('/book/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    cur.execute("DELETE FROM books WHERE id = %s", (book_id,))
    conn.commit()
    return jsonify({"message": "Book deleted successfully"})

# Створення нової позики


@app.route('/loan', methods=['POST'])
def create_loan():
    data = request.json
    book_id = data['book_id']
    reader_id = data['reader_id']
    loan_date = data['loan_date']
    return_date = data.get('return_date')
    cur.execute("INSERT INTO loans (book_id, reader_id, loan_date, return_date) VALUES (%s, %s, %s, %s)",
                (book_id, reader_id, loan_date, return_date))
    conn.commit()
    return jsonify({"message": "Loan created successfully"}), 201

# Отримання інформації про всі позики


@app.route('/loan', methods=['GET'])
def get_all_loans():
    cur.execute("SELECT * FROM loans")
    loans = cur.fetchall()
    return jsonify([dict(loan) for loan in loans])

# Отримання інформації про конкретну позику за її ідентифікатором


@app.route('/loan/<int:loan_id>', methods=['GET'])
def get_loan_by_id(loan_id):
    cur.execute("SELECT * FROM loans WHERE id = %s", (loan_id,))
    loan = cur.fetchone()
    if loan:
        return jsonify(dict(loan))
    else:
        return jsonify({"message": "Loan not found"}), 404

# Оновлення інформації про позику


@app.route('/loan/<int:loan_id>', methods=['PUT'])
def update_loan(loan_id):
    data = request.json
    book_id = data['book_id']
    reader_id = data['reader_id']
    loan_date = data['loan_date']
    return_date = data.get('return_date')
    cur.execute("UPDATE loans SET book_id = %s, reader_id = %s, loan_date = %s, return_date = %s WHERE id = %s",
                (book_id, reader_id, loan_date, return_date, loan_id))
    conn.commit()
    return jsonify({"message": "Loan updated successfully"})

# Видалення позики за її ідентифікатором


@app.route('/loan/<int:loan_id>', methods=['DELETE'])
def delete_loan(loan_id):
    cur.execute("CALL delete_loan(%s)", (loan_id,))
    conn.commit()
    return jsonify({"message": "Loan deleted successfully"})


if __name__ == '__main__':
    app.run(debug=True)
