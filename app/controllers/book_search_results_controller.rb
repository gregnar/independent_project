class BookSearchResultsController < ApplicationController

  def index
    @results = search_results.work
  end

  private

  def search_results
    basic_goodreads_client.search_books(params[:q]).results
  end

end
