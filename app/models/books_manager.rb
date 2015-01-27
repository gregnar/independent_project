class BooksManager

  def self.update_book(book_hash)
    unless existing_book(book_hash)
      Book.create( goodreads_id: book_hash['id'],
                   small_image_url: book_hash['small_image_url'],
                   image_url: book_hash['image_url'],
                   title: book_hash['title'],
                   goodreads_rating: book_hash['average_rating']
                  )
    end
  end
  
  def self.existing_book(book_hash)
    Book.find_by(goodreads_id: book_hash['goodreads_id'])
  end

end
