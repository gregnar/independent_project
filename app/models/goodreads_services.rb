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

  def followees
    XMLParser.parse_followees(user.get(BASE_URL + "/user/#{@user_id}/following?format=xml").body)
  end

  def update_followees
    FolloweesManager.new(user_object, followees).update_followees
  end

  def get_ratings_for_single_user(goodreads_id)
    user.get(BASE_URL + "/review/list/#{goodreads_id}.xml").body
  end

  def update_followee_ratings
    RatingsManager.new(user_object, all_ratings_for_user)
  end


  private

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

  def parse_ratings_for_single_user(goodreads_id)
    XMLParser.parse_ratings(get_ratings_for_single_user(goodreads_id))
  end

  def collect_all_ratings_for_user
    user_object.followees.inject([]) do |array, f|
      array.tap { |a| a << parse_ratings_for_single_user(f.goodreads_id) }
    end
  end

end
