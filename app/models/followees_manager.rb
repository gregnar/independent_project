class FolloweesManager

  def initialize(user, followees)
    @user      = user
    @followees = followees
  end

  def self.update_followees_for_user
    followees.each do |followee_hash|
      create_followee(followee_hash) unless existing_followee(followee_hash[:id])
    end
  end

  private

  def user
    @user
  end

  def followees
    @followees
  end

  def self.create_followee(followee_hash)
    attributes = followee_attributes(followee_hash)
    user.followees.create(attributes)
  end

  def self.existing_followee(followee_id)
    user.followees.find_by(goodreads_id: followee_id)
  end


  def self.followee_attributes(followee_hash)
    followee_hash.slice(:id, :name, :link, :image_url, :small_image_url)
                 .tap { |h| h[:goodreads_id] = h[:id], h.delete[:id]}
  end

end
