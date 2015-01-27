class BookSearchResultsManager

    def self.sanitize_books(search_results)
      results_with_fixed_rating = reassign_average_rating(search_results)
      use_best_book_hash(results_with_fixed_rating)
    end

    def self.reassign_average_rating(search_results)
      search_results.each do |r|
        r.best_book.goodreads_rating = r.average_rating
        r.goodreads_id = id
      end
    end

    def self.use_best_book_hash(results_with_fixed_rating)
      results_with_fixed_rating.map(&:best_book)
    end

end
