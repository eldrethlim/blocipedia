class User < ActiveRecord::Base

  has_one :subscription

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