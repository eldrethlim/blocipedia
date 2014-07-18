class PagePolicy < ApplicationPolicy
  
  def create?
    check_page_owner_collab_or_admin
  end

  def update?
    create?
  end

  def destroy?
    check_page_owner_collab_or_admin
  end

  def show?
    record.wiki.public? || check_page_owner_collab_or_admin
  end

  private

  def check_page_owner_collab_or_admin
    user.present? && (record.wiki.user == user || user.role?(:admin) || record.wiki.collaborators.include?(user))
  end
end