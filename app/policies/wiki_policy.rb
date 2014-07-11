class WikiPolicy < ApplicationPolicy

  def index?
    user.present? && (user.role(:admin) || record.user == user)
  end

  def show?
    record.public? || wikipolicy_params
  end

  def create?
    user.present?
  end

  def update?
    create?
  end

  def destroy?
    wikipolicy_params
  end

  def wikipolicy_params
    user.present? && (record.user == user || user.role?(:admin) || record.collaborators.include?(user))
  end
end