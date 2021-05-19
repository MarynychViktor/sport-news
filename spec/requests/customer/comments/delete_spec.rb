require 'rails_helper'

describe ' DELETE /articles/:article_id/comments/:id', type: :request, comments: true, delete: true do
  describe 'when user is not logged in' do
    let(:user) { create(:user) }
    let(:article) { create(:article, published_at: DateTime.current) }
    let(:comment_attributes) { attributes_for(:comment) }

    it 'returns unauthorized response' do
      post article_comments_path(article), params: { comment: comment_attributes },
                                           headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'when user logged in' do
    let(:user) { create(:user) }
    let!(:article) { create(:article, published_at: DateTime.current) }
    let!(:comment) { create(:comment, article: article, user: user)}
    let!(:non_user_comment) { create(:comment, article: article)}
    before(:each) { sign_in(user) }

    it 'deletes comment' do
      comments_count = article.comments.count
      delete article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }
      expect(article.comments.count).to be(comments_count - 1)
    end

    it 'receives error on attempt to delete others comment' do
      delete article_comment_path(article, non_user_comment), headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
