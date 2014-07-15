class Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  has_many :subpages

  validates_presence_of :name
  after_create :set_page_default_body

  private

  def set_page_default_body
    self.update(body: "Edit your page now")
  end
end