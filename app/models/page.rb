class Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates_presnce_of :name
end