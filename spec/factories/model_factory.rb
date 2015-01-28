FactoryGirl.define do

  factory :user do
    goodreads_id "1"
  end

  factory :access_token do
    token 'abc'
    secret '123'
    association :user, factory: :user
  end

end
