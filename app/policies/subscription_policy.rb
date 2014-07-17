class SubscriptionPolicy < ApplicationPolicy

  def new?
    user.present? && user.subscribed?
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present?
  end

  def show?
    user.present?
  end

  def check_user_and_role
    user.present? && (record.user == user || user.role(:admin))
  end
end