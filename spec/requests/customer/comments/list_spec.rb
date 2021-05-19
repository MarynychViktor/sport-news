require 'rails_helper'

describe 'GET /articles/:article_id/comments', type: :request, comments: true, list: true do
  describe 'when user is non admin' do
    let(:user) { create(:user) }
    let(:article) { create(:article, published_at: DateTime.current) }
    let(:unpublished_article) { create(:article) }
    let!(:comment) { create(:comment, article: article) }
    let!(:child_comment1) { create(:comment, article: article, thread: comment, parent: comment) }
    let!(:child_comment2) { create(:comment, article: article, thread: comment, parent: comment) }
    before(:each) { sign_in(user) }

    it 'returns paginated response' do
      get article_comments_path(article), headers: { 'ACCEPT' => 'application/json' }

      body = JSON.parse(response.body)
      expect(body).to have_key('last_page')
      expect(body).to have_key('page')
      expect(body).to have_key('total')
      expect(body).to have_key('data')
    end

    it 'returns only root comments' do
      get article_comments_path(article), headers: { 'ACCEPT' => 'application/json' }

      body = JSON.parse(response.body)
      expect(body['total']).to be(1)
      expect(body['data'][0]['id']).to be(comment.id)
    end

    it 'cant view comments for unpublished articles' do
      get article_comments_path(unpublished_article), headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'when user is admin' do
    let(:user) { create(:user, admin: true) }
    let(:unpublished_article) { create(:article) }
    before(:each) { sign_in(user) }

    it 'can view comments for unpublished articles' do
      get article_comments_path(unpublished_article), headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:success)
    end
  end
end
