class PagePolicy < ApplicationPolicy
  
  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
  end

  def show?
    user.present?
  end

  def pageparams
    user.present && (record.user(user) || user.role?(:admin))
  end

end