class CommentPolicy < ApplicationPolicy
  def update?
    author?
  end

  def destroy?
    author?
  end

  private

  def author?
    @record.user_id == @user.id
  end
end