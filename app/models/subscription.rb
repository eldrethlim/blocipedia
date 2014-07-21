class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  validates_presence_of :plan_id

  attr_accessor :stripe_card_token

  def save_with_payment(token, email)
    if valid?
      customer = Stripe::Customer.create(
        email: email, 
        card: token, 
        plan: self.plan.stripe_id
      )

      self.user = User.find_by_email(email)
      self.stripe_customer_id = customer.id

       require 'pry'; binding.pry
      
      card_id = customer.default_card #card the customer used to pay
      cards = customer.cards.data # array of cards

      self.last4 = cards.find { |card| card.id == card_id }.last4
      self.cardname = cards.find { |card| card.id == card_id }.brand
      self.stripe_subscription_id = customer.subscriptions.first.id
      self.user.update(subscribed: true)
      save!
    end

      rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem updating your payment details."
      false
  end

  def update_card(card_info)
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
      customer.card = token.id
      customer.save

      card_id = customer.default_card #card the customer used to pay
      cards = customer.cards.data # array of cards

      self.last4 = cards.find { |card| card.id == card_id }.last4
      self.cardname = cards.find { |card| card.id == card_id }.brand
      save!
    end

      rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem updating your payment details."
      false
  end

  def change_subscription(plan_stripe_id)
    if valid?

      customer = Stripe::Customer.retrieve(self.stripe_customer_id)
      subscription = customer.subscriptions.retrieve(self.stripe_subscription_id)
      subscription.plan = plan_stripe_id
      subscription.prorate = true
      subscription.save
      
      self.stripe_subscription_id = customer.subscriptions.first.id
      save!
    end

      rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem updating your payment details."
      false
  end
    
  def cancel_subscription
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_id)
      subscription = customer.subscriptions.retrieve(self.stripe_subscription_id)
      subscription.delete(:at_period_end => true)
    end

      rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem updating your payment details."
      false
  end
end