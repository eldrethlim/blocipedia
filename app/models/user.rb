class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  has_many :collaborations
  has_many :collab_wikis, class_name: "Wiki", source: :wiki, through: :collaborations
  has_many :wikis
  has_many :pages
  has_many :subpages
  has_one :subscription
  validates_uniqueness_of :username, :email
  validates :username, :name, :address, :postcode, :state, presence: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  enum role: [:banned, :user, :admin]
  after_initialize :set_default_role_and_subscription, :if => :new_record?

  mount_uploader :profilepic, ProfilepicUploader

  def set_default_role_and_subscription
    self.role ||= :user
    self.subscribed ||= false
  end

  def role?(base_role)
    role == base_role.to_s
  end

  def can_create_private_wiki?
    self.subscribed? || role?(:admin)
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end