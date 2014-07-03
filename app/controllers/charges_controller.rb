class ChargesController < ApplicationController
def create

  @amount = params[:amount]

  # Creates a Stripe Customer object, for associating
  # with the charge

  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: @amount,
    description: "Premium Wikispace User - #{current_user.email}",
    currency: 'usd'
  )

  flash[:success] = "Thanks for supporting Blocipedia, #{current_user.name}! We'll do our best to earn your continuous support!"
  redirect_to user_path(current_user)

  # Stripe will send back Card errors, with friendly messages when something goes wrong.

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
end

def new
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Blocipedia Membership - #{current_user.name}",
    amount: 10_00
  }
end

end