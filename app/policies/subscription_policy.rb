class SubscriptionPolicy < ApplicationPolicy

  def create?
    user.present? && user.subscription.nil?
  end

  def update?
    record.user == user || user.role?(:admin)
  end

  def destroy?
    record.user == user || user.role?(:admin)
  end
end