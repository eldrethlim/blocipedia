class Collaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user

  def add_collaborators(users, wiki_id)
    users.each do |user|
      self.wiki = @wiki
      self.user = user
      save!
    end
  end
end