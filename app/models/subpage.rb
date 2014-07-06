class Subpage < ActiveRecord::Base
  belongs_to :user
  belongs_to :page

  validates_presence_of :name
end
