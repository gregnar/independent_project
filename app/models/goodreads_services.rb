class GoodreadsServices
  def self.current_access_token
    @current_access_token ||= OAuth::AccessToken.new( consumer,
                                                      access_token,
                                                      access_token_secret
                                                    )
  end

  def self.access_token
    current_user.access_token.token
  end

  def self.access_token_secret
    current_user.access_token.secret
  end

  def self.consumer
    @consumer ||= OAuth::Consumer.new(  Figaro.env.goodreads_key,
                                        Figaro.env.goodreads_secret,
                                        site: 'http://www.goodreads.com'
                                      )
  end

end
