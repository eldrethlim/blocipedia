# Store the environment variables on the Rails.configuration object
require "stripe"

Rails.configuration.stripe = {
  :secret_key => ENV['STRIPE_SECRET_KEY'],
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]