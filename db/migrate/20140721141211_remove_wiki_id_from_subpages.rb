class RemoveWikiIdFromSubpages < ActiveRecord::Migration
  def change
    remove_column :subpages, :wiki_id, :integer
  end
end
