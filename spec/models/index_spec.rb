require 'rails_helper'
require 'capybara/rails'

describe "Properly view home page" do
  visit '/welcome/index'
  expect(page).to have_content('Blocipedia')
end