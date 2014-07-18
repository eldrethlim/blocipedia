class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  validates_presence_of :plan_id

  attr_accessor :stripe_card_token

  def save_with_payment(token, email)
    if valid?
      customer = Stripe::Customer.create(email: email, card: token)
      customer.subscriptions.create(:plan => self.plan.stripe_id)


      self.user = User.find_by_email(email)
      self.stripe_customer_id = customer.id
      
      card_id = customer.default_card #card the customer used to pay
      cards = customer.cards.data # array of cards
      require 'pry'; binding.pry

      self.last4 = cards.find { |card| card.id == card_id }.last4
      self.cardname = cards.find { |card| card.id == card_id }.brand
      self.user.update_attribute(:subscribed, true)
      save!
    end
    
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem creating a new subscription plan."
    false
  end


end