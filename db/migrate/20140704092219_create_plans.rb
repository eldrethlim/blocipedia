class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :stripe_id
      t.string :name
      t.decimal :price
      t.integer :duration
    end
  end
end
