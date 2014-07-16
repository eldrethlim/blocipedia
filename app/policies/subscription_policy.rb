class SubscriptionPolicy < ApplicationPolicy

  def create?
    user.present? && user.subscription.nil?
  end

  def update?
    check_user_and_role
  end

  def destroy?
    check_user_and_role
  end

  def check_user_and_role
    user.present? && (record.user == user || user.role(:admin))
  end
end