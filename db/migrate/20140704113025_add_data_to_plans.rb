class AddDataToPlans < ActiveRecord::Migration
  def up
    Plan.create!(name: 'Annual Premium Plan', price: 110, duration: 12, stripe_id: 'annualpremium')
    Plan.create!(name: 'Monthly Premium Plan', price: 10, duration: 1, stripe_id: 'monthlypremium')
  end

  def down
    Plan.delete_all
  end
end