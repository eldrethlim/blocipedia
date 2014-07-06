class CreateSubpages < ActiveRecord::Migration
  def change
    create_table :subpages do |t|
      t.integer :page_id
      t.string :name
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
