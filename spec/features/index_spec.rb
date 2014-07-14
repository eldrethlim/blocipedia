require 'rails_helper'
require 'capybara/rails'

feature "Signing In" do

  scenario "View Blocipedia name in homepage" do
    visit '/'
    expect(page).to have_content "Blocipedia"
  end
end