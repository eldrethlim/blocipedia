class AddWikiIdToSubpage < ActiveRecord::Migration
  def change
    add_column :subpages, :wiki_id, :integer
  end
end
