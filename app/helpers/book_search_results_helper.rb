module BookSearchResultsHelper

  def custom_rating(book)
    book.goodreads_id ? id = book.goodreads_id : id = book.id
    current_user.custom_rating(id)
  end

end
