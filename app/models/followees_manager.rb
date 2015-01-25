class FolloweesManager

  def self.update_followees_for_user(user, followees)
    followees.each do |followee_hash|
      create_followee(user, followee_hash) unless existing_followee(user, followee_hash[:id])
    end
  end

  private

  def self.create_followee(user, followee_hash)
    attributes = followee_attributes(followee_hash)
    user.followees.create(attributes)
  end

  def self.existing_followee(user, followee_id)
    user.followees.find_by(goodreads_id: followee_id)
  end


  def self.followee_attributes(followee_hash)
    followee_hash.slice!(:id, :name, :link, :image_url, :small_image_url)
                 .tap { |h| h[:goodreads_id] = h[:id], h.delete[:id]}
  end

end
