class SubpagePolicy < ApplicationPolicy
    def create?
    user.present?
  end

  def update?
    create?
  end

  def destroy?
  end

  def show?
    user.present?
  end
end