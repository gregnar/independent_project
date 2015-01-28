class RatingsAndBooksManager

  def self.update_ratings_and_books(data)
    cleaned_data = clean_data_up(data)
    cleaned_data.each do |d|
      BooksManager.update_book(d['book']); d.delete('book')
      RatingsManager.create(d)
    end
  end

  def self.clean_data_up(data)
       data.reject { |d| d['rating'] == '0' }
           .map    { |d| select_needed_keys(d) }
  end

  def self.select_needed_keys(rating_hash)
    rating_hash.slice('followee_id', 'book', 'rating')
               .tap { |h| h['book_id'] = h['book']['id']}
  end
end
