class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  belongs_to :wiki
  has_many :subpages , dependent: :destroy

  validates_presence_of :name
  after_create :set_page_default_body

  private

  def set_page_default_body
    self.update(body: "Edit your page now")
  end
end