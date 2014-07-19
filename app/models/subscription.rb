class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  validates_presence_of :plan_id

  attr_accessor :stripe_card_token

  def save_with_payment(token, email)
    if valid?
      customer = Stripe::Customer.create(email: email, card: token, plan: self.plan.stripe_id)

      self.user = User.find_by_email(email)
      self.stripe_customer_id = customer.id
      
      card_id = customer.default_card #card the customer used to pay
      cards = customer.cards.data # array of cards

      self.last4 = cards.find { |card| card.id == card_id }.last4
      self.cardname = cards.find { |card| card.id == card_id }.brand
      self.stripe_subscription_id = customer.subscriptions.first
      self.user.update_attribute(:subscribed, true)
      save!
    end

    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem creating a new subscription plan."
    false
  end

  def update_card(subscriber, card_info)
    if valid?
      token = Stripe::Token.create(
        card: {
          number: card_info[:number],
          exp_month: card_info[:exp_month],
          exp_year: card_info[:exp_year],
          cvc: card_info[:cvc]
        }
      )

      customer = Stripe::Customer.retrieve(self.stripe_customer_id)
      card = customer.cards.create(card: token)
      card.save
      customer.default_card = card.id
      customer.save
      require 'pry'; binding.pry
    end

      rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem updating your payment details."
      false
  end

  def change_subscription
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_id)
      subscription = customer.subscriptions.retrieve(self.stripe_subscription_id)
      subscription.plan = 
      subscription.prorate = true

    end
  end
    

end