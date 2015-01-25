class XMLParser

  def self.parse_followees(followees)
    @followees = followees; followee_hashes
    # followee_hashes.map { |hash| OpenStruct.new(hash) }
  end

  def self.first_attempt
    Hash.from_xml(@followees.gsub(/\s*\\n*t*/, ""))
  end

  def self.followee_hashes
    first_attempt['GoodreadsResponse']['following']['user']
  end

end
