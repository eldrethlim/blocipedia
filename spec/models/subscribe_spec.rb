require 'rails_helper'

feature "FeatureEditCreditCard" do
  
  background do 
    @user = User.new(
    name: "Bob",
    username: "bob",
    email: "bob@test.com",
    password: 'password',
    address: "address",
    postcode: "postcode",
    state: "Casterly Rock",
    country: "MY"
    )
    @user.skip_confirmation!
    @user.save!

    token = Stripe::Token.create(
      :card => {
        number: "4242424242424242",
        exp_month: 3,
        exp_year: 2015,
        cvc: "555"
      }
    )

    plan = Plan.new(
      stripe_id: "annualpremium",
      name: "name",
      price: "100",
      duration: 12
    )
    plan.save!

    customer = Stripe::Customer.create(
      email: "bob@test.com",
      card: token.id,
      plan: plan.stripe_id
    )

    subscription = Subscription.create!(
      plan_id: plan.id,
      user_id: @user.id,
      stripe_customer_id: customer.id,
      )

    @user.update(subscribed: true)
  end

  scenario "Signing in and making a subscription" do
    visit '/users/sign_in'
    within ('#new_user') do
      fill_in 'Email', :with => "bob@test.com"
      fill_in 'Password', :with => 'password'
    end
    click_button 'Sign in'
    click_link 'Bob'
    click_link 'Edit subscription options'
    within ('#update_payment_details') do
      fill_in 'Card Number', :with => "4242424242424242"
      fill_in 'Security Code', :with => "555"
      #find('#exp_year').find(:exp_year, '2015').select_option
      select '2015', from: 'exp_year'
    end
    click_button 'Update'
    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content 'Your payment details have been updated'
  end
end