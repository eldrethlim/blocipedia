class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :wiki_name
      t.boolean :public

      t.timestamps
    end
  end
end
