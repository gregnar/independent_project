class GoodreadsServices

  def self.follow(user_id)
    authorized_goodreads_user.
  end

  private

  def self.authorized_goodreads_user
    @authorized_goodreads_user ||= OAuth::AccessToken.new(consumer,
                                                          access_token_key,
                                                          access_token_secret
                                                         )
  end

  def self.access_token_key
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

  def self.convert_to_openstruct(data)
    OpenStruct.new(data)
  end
end
