require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { FactoryGirl.create(:user) }

  it "can set an access token" do
    return_value = user.set_access_token("123", "abc")

    expect(return_value).to be_an_instance_of AccessToken
  end

end
