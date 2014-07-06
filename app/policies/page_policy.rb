class PagePolicy < ApplicationPolicy

  def index?
  end

  def create?
    user.present?
  end

  def update?
    create?
  end
end