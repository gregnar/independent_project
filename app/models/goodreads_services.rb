class GoodreadsServices
  BASE_URL = "http://www.goodreads.com"
  CONSUMER = OAuth::Consumer.new( Figaro.env.goodreads_key,
                                  Figaro.env.goodreads_secret,
                                  site: BASE_URL
                                )

  def initialize(user_object)
    @user_object         = user_object
    @user_id             = user_object.goodreads_id
    @access_token_key    = user_object.access_token.token
    @access_token_secret = user_object.access_token.secret
  end

  def follow(foreign_user_id)
    user.post(BASE_URL + "/user/#{foreign_user_id}/followers?format=xml")
  end

  def custom_rating(book_id)
    RatingsGenerator.generate_rating(user_id, book_id)
  end

  def followees
    XMLParser.parse_followees(user.get(BASE_URL + "/user/#{@user_id}/following?format=xml").body)
  end

  def update_followees
    FolloweesManager.new(@user_object, followees).update_followees
  end

  private

  def user
    @user ||= OAuth::AccessToken.new(CONSUMER, access_token_key, access_token_secret)
  end

  def access_token_key
    @access_token_key
  end

  def access_token_secret
    @access_token_secret
  end


end
