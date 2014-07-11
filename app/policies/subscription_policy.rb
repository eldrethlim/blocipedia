class SubscriptionPolicy < ApplicationPolicy

  def create?
    user.present? && user.subscription.nil?
  end

  def update?
    subscription_params
  end

  def destroy?
    subscription_params
  end

  def subscription_params
    user.present? && (record.user == user || user.role(:admin))
  end
end