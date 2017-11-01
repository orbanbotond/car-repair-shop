class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    if user.has_role? :admin
      true
    else
      false
    end
  end

  def show?
    if user.has_role? :admin
      true
    else
      is_it_me?
    end
  end

  def create?
    if user.has_role? :admin
      true
    else
      false
    end
  end

  def new?
    create?
  end

  def update?
    if user.has_role? :admin
      true
    else
      is_it_me?
    end
  end

  def edit?
    update?
  end

  def destroy?
    if user.has_role? :admin
      is_it_somebody_else?
    else
      false
    end
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

private

  def is_it_me?
    user.id == record.id
  end

  def is_it_somebody_else?
    user.id != record.id
  end

end
