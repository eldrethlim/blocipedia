class Subpage < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  belongs_to :wiki

  validates_presence_of :name
end
