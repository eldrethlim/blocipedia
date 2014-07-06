class Wiki < ActiveRecord::Base
  has_many :pages
  belongs_to :user

  validates_presence_of :name
end