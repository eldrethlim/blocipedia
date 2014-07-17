class Subpage < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  belongs_to :page
  belongs_to :wiki

  validates_presence_of :name
  after_create :set_subpage_default_body

  private

  def set_subpage_default_body
    self.update(body: "Edit your subpage now")
  end
end
