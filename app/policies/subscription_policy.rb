class SubscriptionPolicy < ApplicationPolicy

  def create?
    if record.user == user
      false
    else
      true
    end
  end

  def update?
    record.user == user || user.role?(:admin)
  end

  def destroy?
    record.user == user || user.role(:admin)
  end
end