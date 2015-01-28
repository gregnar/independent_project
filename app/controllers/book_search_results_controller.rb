class BookSearchResultsController < ApplicationController
  helper BookSearchResultsHelper

  def index
    @results = BookSearchResultsManager.sanitize_books(search_results)
  end

  private

  def search_results
    begin
      GoodreadsServices.search_books(params[:q]).results.work
    rescue
      []
    end
  end

end
