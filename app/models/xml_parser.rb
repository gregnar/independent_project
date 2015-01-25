class XMLParser

  def self.parse_followees(followees)
    followee_hashes(followees)
  end

  def self.parse_ratings(ratings)
    ratings_hashes(ratings)
  end


  private

  def self.ratings_hashes(ratings)
    xml_to_hash(ratings)['GoodreadsResponse']['books']['book']
  end

  def self.xml_to_hash(raw_xml)
    Hash.from_xml(raw_xml.gsub(/\s*\\n*t*/, ""))
  end

  def self.followee_hashes(followees)
    xml_to_hash(followees)['GoodreadsResponse']['following']['user']
  end

end
