class AddCardnameToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cardname, :string
  end
end
