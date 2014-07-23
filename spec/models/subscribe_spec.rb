require 'capybara/rspec'

feature "FeatureEditCreditCard" do

  scenario "Signing in and making a subscription" do
    visit '/users/sign_in'
    within ('#users') do
      fill_in 'Email', :with => "eldrethlim@gmail.com"
      fill_in 'Password', :with => 'helloworld'
    end
    click_button 'Sign In'
    click_link 'Lim Jun Xian'
    click_button 'Edit subscription options'
    within ('subscriptions') do
      fill_in 'Card Number', :with => "4242424242424242"
      fill_in 'Security Code', :with => "555"
      find('#select_year').find(:exp_year, '2015').select_option
    end
    click_button 'Update'
    current_path.should == user_path
    expect(page).to have_content 'Your payment details have been updated'
  end
end