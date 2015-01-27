class SuggestedFollowee < ActiveRecord::Base
  belongs_to :followee
  belongs_to :user

  def reason_for_suggestion
    "Followed by #{followee.name}"
  end
end
