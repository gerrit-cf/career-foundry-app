class ProductPolicy < ApplicationPolicy
  def manage?
    user.admin?
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    manage?
  end

  def edit?
    update?
  end

  def update?
    manage?
  end

  def destroy?
    manage?
  end
end
