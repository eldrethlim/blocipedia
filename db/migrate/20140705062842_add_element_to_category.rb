class AddElementToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :element, :string
  end
end
