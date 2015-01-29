class BooksController < ApplicationController
  
  def index
    @books = current_user.books.paginate(:page => params[:page])
  end
end
