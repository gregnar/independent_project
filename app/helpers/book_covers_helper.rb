module BookCoversHelper
  def medium_cover_image_by_isbn(isbn)
    "http://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg"
  end
end
