class WikiPolicy < ApplicationPolicy

  def show?
    record.public? || check_wiki_owner_collab_or_admin
  end

  def create?
    check_wiki_owner_collab_or_admin
  end

  def update?
    create?
  end

  def destroy?
    check_wiki_owner_collab_or_admin
  end

  def check_wiki_owner_collab_or_admin
    user.present? && (record.user == user || user.role?(:admin) || record.collaborators.include?(user))
  end
end