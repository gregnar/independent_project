class BookSearchResultsController < ApplicationController
  helper BookSearchResultsHelper

  def index
    @results = BookSearchResultsManager.sanitize_books(search_results)
  end

  private

  def search_results
    basic_goodreads_client.search_books(params[:q]).results.work
  end
  
end
