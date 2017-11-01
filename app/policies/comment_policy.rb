class CommentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.has_role? :admin
  end

  def show?
    if user.has_role? :admin
      true
    else
      is_the_repair_mine?
    end
  end

  def create?
    if user.has_role? :admin
      true
    else
      is_the_repair_mine?
    end
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
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

  def is_the_repair_mine?
    record.repair.user_id == user.id
  end

end
