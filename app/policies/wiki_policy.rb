class WikiPolicy < ApplicationPolicy

  def show?
    record.public? || check_wiki_owner_collab_or_admin
  end

  def create?
    user.present?
  end

  def update?
    check_wiki_owner_collab_or_admin
  end

  def destroy?
    check_wiki_owner_collab_or_admin
  end

  def check_wiki_owner_collab_or_admin
    user.present? && (record.user == user || user.role?(:admin) || record.collaborators.include?(user))
  end
end