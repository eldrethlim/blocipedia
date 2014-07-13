FactoryGirl.define do
  factory :user do
    name "Eldreth"
    username "eldreth"
    sequence(:email, 100) { |n| "eldreth#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    address "address"
    state "state"
    country "country"
    postcode "postcode"
    confirmed_at Time.now
  end
end