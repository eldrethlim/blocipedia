FactoryGirl.define do
  factory :user do
    name "Bob"
    username "#{rand}"
    sequence(:email, 100) { |n| "email#{n}@test.com"}
    password "password"
    password_confirmation "password"
    address "adress"
    postcode "postcode"
    state "Casterly Rock"
    country 'MY'
    confirmed_at Time.now
  end
end