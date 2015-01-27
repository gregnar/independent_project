class SuggestedFollowee < ActiveRecord::Base
  belongs_to :followee
  belongs_to :user
end
