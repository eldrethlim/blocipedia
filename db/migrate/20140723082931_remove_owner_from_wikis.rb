class RemoveOwnerFromWikis < ActiveRecord::Migration
  def change
    remove_column :wikis, :owner, :integer
  end
end
