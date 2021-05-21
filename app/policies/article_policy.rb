class ArticlePolicy < ApplicationPolicy
  def show?
    @user&.admin? or @record.published?
  end

  def comment?
    @record.published?
  end
end