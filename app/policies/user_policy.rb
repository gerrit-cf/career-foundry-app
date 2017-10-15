class UserPolicy < ApplicationPolicy
  def manage?
    user.admin? || record_in_scope?
  end

  def show?
    manage?
  end

  def update?
    manage?
  end
end
