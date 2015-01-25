class XMLParser

  def self.parse_followees(followees)
    followee_hashes(followees)
  end

  def self.parse_ratings(followee_id, ratings)
    ratings_hashes(ratings).map { |review| review['followee_id'] = followee_id }
  end

  private

  def self.xml_to_hash(raw_xml)
    Hash.from_xml(raw_xml.gsub(/\s*\\n*t*/, ""))
  end

  def self.followee_hashes(followees)
    xml_to_hash(followees)['GoodreadsResponse']['following']['user']
  end

  def self.ratings_hashes(ratings)
    xml_to_hash(ratings)['GoodreadsResponse']['reviews']
  end

end
