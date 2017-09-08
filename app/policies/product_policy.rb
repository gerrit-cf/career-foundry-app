class ProductPolicy < ApplicationPolicy
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
    true # admin?
  end

  def edit?
    update?
  end

  def update?
    true # admin?
  end

  def destroy
    true # admin?
  end
end
