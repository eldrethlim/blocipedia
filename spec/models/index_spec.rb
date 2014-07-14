require 'rails_helper'
require 'capybara/rails'

scenario "View Blocipedia name in homepage" do
  visit '/welcome/index'
  expect(page).to have_content "Blocipedia"
end