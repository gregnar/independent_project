class BooksManager

  def self.update_book(book_hash)
    unless Book.find_by(goodreads_id: book_hash['goodreads_id'])
      Book.create( goodreads_id: book_hash['id'],
                   small_image_url: book_hash['small_image_url'],
                   image_url: book_hash['image_url'],
                   title: book_hash['title'],
                  )
    end
  end

end
