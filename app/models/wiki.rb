class Wiki < ActiveRecord::Base
  has_many :pages, dependent: :destroy
  has_many :subpages, dependent: :destroy
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, class_name: "User", source: :user, through: :collaborations

  validates_presence_of :name
  before_create :check_default_privacy
  before_create :set_default_privacy
  
  private

  def check_default_privacy
    if !self.user.can_create_private_wiki?
      self.public = true
    end
  end

  def set_default_privacy
    if self.public.nil?
      self.public = true
    end
  end
end