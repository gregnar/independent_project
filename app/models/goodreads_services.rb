class GoodreadsServices
  BASE_URL = "http://www.goodreads.com"
  CONSUMER = OAuth::Consumer.new( Figaro.env.goodreads_key,
                                  Figaro.env.goodreads_secret,
                                  site: BASE_URL
                                )

  def initialize(user_object=nil)
    @user_object         = user_object
    @user_id             = user_object.goodreads_id
    @access_token_key    = user_object.access_token.token
    @access_token_secret = user_object.access_token.secret
  end

  def follow(foreign_user_id)
    user.post(BASE_URL + "/user/#{foreign_user_id}/followers?format=xml")
  end

  def followees
    XMLParser.parse_followees(get_user_followees)
  end

  def get_followees(user_id)
    user.get(BASE_URL + "/user/#{user_id}/following?format=xml").body
  end

  def get_user_followees
    get_followees(@user_id)
  end

  def update_followees
    FolloweesManager.new(user_object, followees).update_followees
  end

  def get_ratings_and_books_for_single_user(goodreads_id)
    user.get(BASE_URL + "/review/list/#{goodreads_id}.xml?v=2&per_page=200").body
  end

  def update_ratings_and_books
    RatingsAndBooksManager.update_ratings_and_books(all_parsed_ratings_and_books_for_user)
  end

  def update_books
    raw_book_data = get_book_data(ids_of_books_to_update)
    BooksManager.update_books(raw_book_data)
  end

  def update_suggested_followees
    user_object.followees.map do |f|
      raw_suggestions = get_followees(f.goodreads_id)
      parsed_suggestions = XMLParser.parse_followees(raw_suggestions)
      next unless parsed_suggestions
      SuggestedFolloweesManager.new(user_object, f, parsed_suggestions).update_suggested_followees
    end
  end

  def compare(user_id)
    XMLParser.parse_comparison(get_comparison(user_id))
  end

  def get_comparison(user_id)
    user.get(BASE_URL + "/user/compare/#{user_id}.xml").body
  end

  def add_book(book_id)
    user.post(BASE_URL + "/shelf/add_to_shelf.xml?book_id=#{book_id}&name=to-read")
  end

  def self.search_books(query)
    goodreads_gem.search_books(query)
  end

  private

  def ids_of_books_to_update
    user_object.uncached_book_ids
  end

  def get_book_data(ids)
    ids.map { |id| goodreads_gem.book(id) }
  end

  def goodreads_gem
    @goodreads_gem ||= Goodreads.new
  end

  def self.goodreads_gem
    @goodreads_gem ||= Goodreads.new
  end

  def user
    @user ||= OAuth::AccessToken.new(CONSUMER, access_token_key, access_token_secret)
  end

  def user_object
    @user_object
  end

  def access_token_key
    @access_token_key
  end

  def access_token_secret
    @access_token_secret
  end

  def parse_ratings_and_books_for_single_user(followee_id, followee_goodreads_id)
    XMLParser.parse_ratings_and_books(followee_id, get_ratings_and_books_for_single_user(followee_goodreads_id))
  end

  def all_parsed_ratings_and_books_for_user
    user_object.followees.inject([]) do |array, f|
      array << parse_ratings_and_books_for_single_user(f.id, f.goodreads_id); array
    end.flatten
  end

end
