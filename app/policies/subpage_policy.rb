class SubpagePolicy < ApplicationPolicy
    def create?
    user.present?
  end

  def update?
  end

  def destroy?
  end

  def show?
    user.present?
  end
end