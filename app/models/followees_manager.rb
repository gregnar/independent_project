class FolloweesManager

  def initialize(user, followees)
    @user      = user
    @followees = followees
  end

  def update_followees
    followees.each do |followee_hash|
      create_followee(followee_hash) unless existing_followee?(followee_hash)
    end
  end

  private

  def user
    @user
  end

  def followees
    @followees
  end

  def create_followee(followee_hash)
    attributes = followee_attributes(followee_hash)
    user.followees.create!(attributes)
  end

  def existing_followee?(followee_hash)
    user.followees.find_by(goodreads_id: followee_hash['id'])
  end


  def followee_attributes(followee_hash)
    followee_hash.slice('id', 'name', 'link', 'image_url', 'small_image_url')
                 .tap { |h| h['goodreads_id'] = h['id'], h.delete('id') }
  end

end
