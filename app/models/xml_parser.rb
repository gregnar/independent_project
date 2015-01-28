class XMLParser

  def self.parse_followees(followees)
    followee_hashes(followees)
  end

  def self.parse_ratings(followee_id, ratings)
    new_ratings = ratings_hashes(ratings)
    new_ratings.map { |rating| rating.tap { |r| r['followee_id'] = followee_id } }
  end

  def self.parse_comparison(comparison)
    parsed_comparison = comparison_hashes(comparison)
    parsed_comparison.is_a?(Array) ? parsed_comparison : Array.new(1, parsed_comparison)
  end

  private

  def self.comparison_hashes(comparison)
    begin
      xml_to_hash(comparison)['GoodreadsResponse']['compare']['reviews']['review']
    rescue
      []
    end
  end

  def self.xml_to_hash(raw_xml)
    Hash.from_xml(raw_xml)
  end

  def self.followee_hashes(followees)
    xml_to_hash(followees)['GoodreadsResponse']['following']['user']
  end

  def self.ratings_hashes(ratings)
    xml_to_hash(ratings)['GoodreadsResponse']['reviews']['review']
  end

end
