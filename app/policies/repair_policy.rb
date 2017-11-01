class RepairPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    true
  end

  def show?
    if user.has_role? :admin
      true
    else
      is_it_assigned_to_me?
    end
  end

  def create?
    user.has_role? :admin
  end

  def new?
    create?
  end

  def update?
    if user.has_role? :admin
      true
    else
      is_it_assigned_to_me?
    end
  end

  def edit?
    update?
  end

  def destroy?
    user.has_role? :admin
  end

  def complete?
    if user.has_role? :admin
      true
    else
      is_it_assigned_to_me?
    end
  end

  def uncomplete?
    user.has_role? :admin
  end

  def approve?
    user.has_role? :admin
  end

  def assign_user?
    user.has_role? :admin
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

  def is_it_assigned_to_me?
    record.user_id == user.id
  end

end
