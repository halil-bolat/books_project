class Book
  attr_accessor :id, :title, :body

  def self.open_connection
    conn = PG.connect(dbname:"books", user:"postgres")
  end

  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM books WHERE id  = #{id}"
    result = conn.exec (sql)
    book = self.hydrate result[0]
    return book
  end

  def self.edit id, title, body
    conn = self.open_connection
    sql = "UPDATE books SET title = '#{title}', body = '#{body}' WHERE id = #{id};"
    result = conn.exec (sql)
    book = self.hydrate result[0]
    return book
  end

  def self.delete id
    conn = self.open_connection
    sql = "DELETE FROM books WHERE id = #{id};"
    result = conn.exec (sql)
    book = self.hydrate result[0]
    return book
  end

  def self.add id
    conn = self.open_connection
    sql = "INSERT INTO books (title, body) VALUES ('#{:title}', '#{:body}');"
    result = conn.exec (sql)
    book = self.hydrate result[0]
    return book
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM books ORDER BY id"
    result = conn.exec (sql)
    books = result.map do |tuple|
      self.hydrate tuple
    end
    books
  end

  def self.hydrate book_data
    book = Book.new
    book.id = book_data['id']
    book.title = book_data['title']
    book.body = book_data['body']
    return book
  end


end
