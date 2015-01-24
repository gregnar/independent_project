class GoodreadsServices
  BASE_URL = "http://www.goodreads.com"
  CONSUMER = OAuth::Consumer.new( Figaro.env.goodreads_key,
                                  Figaro.env.goodreads_secret,
                                  site: BASE_URL
                                )

  def initialize(goodreads_id, key, secret)
    @user_id             = goodreads_id
    @access_token_key    = key
    @access_token_secret = secret
  end

  def follow(user_id)
    user.post(BASE_URL + "/user/#{user_id}/followers?format=xml")
  end

  def followees(user_id)
    XMLParser.parse_followees(user.get(BASE_URL + "/user/#{user_id}/following?format=xml").body)
  end

  def custom_rating(book_id)
    RatingsGenerator.generate_rating(user_id book_id)
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

  def self.convert_to_openstruct(data)
    OpenStruct.new(data)
  end

end
