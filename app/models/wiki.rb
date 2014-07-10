class Wiki < ActiveRecord::Base
  has_many :pages
  has_many :subpages
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, class_name: "User", source: :user, through: :collaborations

  validates_presence_of :name
end