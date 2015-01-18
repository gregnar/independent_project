module BookCoversHelper

  def isbn_from_goodreads_id(id)
    book = basic_goodreads_client.book(id); book.isbn
  end

  def medium_by_isbn(isbn)
    "http://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg"
  end

  def medium_by_id(id)
    isbn = isbn_from_goodreads_id(id); medium_by_isbn(isbn)
  end

  def medium_cover_image(book)
    book.isbn ? medium_by_isbn(book.isbn) : medium_by_id(book.id)
  end
end
