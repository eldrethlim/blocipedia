class AddLastfourToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last4, :string
  end
end
