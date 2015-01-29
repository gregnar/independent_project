class BookOnShelfController < ApplicationController

  def create
    book_id = params[:book_goodreads_id]
    current_user.add_book(book_id)
    redirect_to :back, notice: "Book added to 'to-read' shelf."
  end

end
