FactoryGirl.define do
  factory :wiki do
    name "First Wiki"
    body "This is a new main page content."
    user
  end
end