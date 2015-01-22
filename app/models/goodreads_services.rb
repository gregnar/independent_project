class GoodreadsServices
  CONSUMER = OAuth::Consumer.new( Figaro.env.goodreads_key,
                                  Figaro.env.goodreads_secret,
                                  site: 'http://www.goodreads.com'
                                )

  def initialize(key, secret)
    @access_token_key    = key
    @access_token_secret = secret
  end

  def follow(user_id)
    user.post("http://www.goodreads.com/user/#{user_id}/followers?format=xml")
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
