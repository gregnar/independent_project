require 'rails_helper'

RSpec.describe SimilarityCalculator, :type => :model do
  let(:comparison) { [ {"book"=>{"title"=>"A Good Man is Hard to Find and Other Stories", "id"=>"48464", "url"=>"http://www.goodreads.com/book/show/48464.A_Good_Man_is_Hard_to_Find_and_Other_Stories"}, "your_review"=>{"id"=>"462364909", "rating"=>"4"}, "their_review"=>{"id"=>"962", "rating"=>"5"}},
                       {"book"=>{"title"=>"A Good Man is Hard to Find and Other Stories", "id"=>"48464", "url"=>"http://www.goodreads.com/book/show/48464.A_Good_Man_is_Hard_to_Find_and_Other_Stories"}, "your_review"=>{"id"=>"462364909", "rating"=>"1"}, "their_review"=>{"id"=>"962", "rating"=>"5"}}
                      ]
                   }

  it "gives a similarity score" do
    sim = SimilarityCalculator.new(comparison)calculate_similarity
    expect(sim).to eq(50)
  end

end
