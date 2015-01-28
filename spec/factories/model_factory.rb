FactoryGirl.define do

  factory :user do
    goodreads_id "1"
  end

  factory :access_token do
    token 'abc'
    secret '123'
    association :user, factory: :user
  end

  factory :rating1, class: Rating do
    rating 5
    association :book, factory: :book
  end

  factory :rating2, class: Rating do
    rating 4
    association :book, factory: :book
  end

  factory :followee do
    goodreads_id '5'
    name 'Jen Berkalski'
    link 'www.example.com'
    image_url 'www.example.com'
    small_image_url 'www.example.com'
  end

  factory :followee2, class: Followee do
    goodreads_id '0'
    name 'Mike Berkalski'
    link 'www.example.com'
    image_url 'www.example.com'
    small_image_url 'www.example.com'
  end

  factory :book do
    goodreads_id '0'
    small_image_url "www.example.com"
    image_url "www.example.com"
    title "Moby Dick"
    goodreads_rating '5'
  end

end
