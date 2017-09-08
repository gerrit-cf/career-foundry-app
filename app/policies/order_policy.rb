class OrderPolicy < ApplicationPolicy
  def manage?
    record_in_scope?
  end

  def index?
    true
  end

  def show?
    manage?
  end

  def new
    true
  end

  def create
    true
  end

  def destroy
    manage?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end
end
