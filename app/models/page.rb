class Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  has_many :subpages

  validates_presence_of :name
end