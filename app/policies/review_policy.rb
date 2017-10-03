class ReviewPolicy < ApplicationPolicy
  def manage?
    user.admin?
  end

  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    manage?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.admin?
      scope.none
    end
  end
end
