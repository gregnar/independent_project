class BookSearchResultsController < ApplicationController

  def index
    @results = basic_goodreads_client.search.work
  end

  private

  def search
    client.search_books(params[:query])
  end

end
