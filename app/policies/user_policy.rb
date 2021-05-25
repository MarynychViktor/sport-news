class UserPolicy < ApplicationPolicy
  def block?
    current_user_admin? and !target_admin? and !@record.blocked?
  end

  def activate?
    current_user_admin? and !target_admin? and @record.blocked?
  end

  def add_admin?
    current_user_admin? and !@record.admin? and !@record.blocked?
  end

  def remove_admin?
    current_user_admin? and @record.admin? and !self?
  end

  def destroy?
    current_user_admin? and !self?
  end

  private

  def current_user_admin?
    @user&.admin?
  end

  def target_admin?
    @record.admin?
  end

  def self?
    @user&.id == @record.id
  end
end
