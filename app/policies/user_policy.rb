class UserPolicy < ApplicationPolicy
  def manage?
    user == record
  end

  def show?
    manage?
  end

  def update?
    manage?
  end
end
