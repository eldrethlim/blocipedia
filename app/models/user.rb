class User < ActiveRecord::Base

  has_many :wikis
  has_many :pages
  has_one :subscription
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  enum role: [:free, :premium, :moderator, :admin, :banned]
  after_initialize :set_default_role, :if => :new_record?

  mount_uploader :profilepic, ProfilepicUploader

  def set_default_role
    self.role ||= :free
  end

  def role?(base_role)
    role == base_role.to_s
  end

end