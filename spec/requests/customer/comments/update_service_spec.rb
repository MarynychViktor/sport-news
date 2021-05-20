require 'rails_helper'

describe 'PATCH  /articles/:article_id/comments/:id ', type: :request, comments: true, update: true do
  describe 'when user is not logged in' do
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    let(:comment) { create(:comment, article: article) }

    it 'returns unauthenticated response' do
      patch article_comment_path(article, comment), params: { comment: { content: 'new content' } },
                                                    headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'when user logged in' do
    context 'with invalid data' do
      let(:user) { create(:user) }
      let(:article) { create(:article, published_at: DateTime.current) }
      let(:comment) { create(:comment, article: article, user: user) }
      before(:each) { sign_in(user) }

      it 'renders errors response when content too short' do
        patch article_comment_path(article, comment), params: { comment: { content: '' } },
                                                      headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:bad_request)
        expect(body).to have_key('content')
      end

      it 'renders errors response when content too long' do
        patch article_comment_path(article, comment), params: { comment: { content: 't'*256 } },
                                                      headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:bad_request)
        expect(body).to have_key('content')
      end
    end

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:article) { create(:article, published_at: DateTime.current) }
      let(:comment) { create(:comment, article: article, user: user) }
      let(:comment_from_another_author) { create(:comment, article: article) }
      before(:each) { sign_in(user) }

      it 'updates comment' do
        patch article_comment_path(article, comment), params: { comment: { content: 'updated' } },
                                                      headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(body['content']).to eql('updated')
      end

      it 'not allowed to update comments from other authors' do
        patch article_comment_path(article, comment_from_another_author), params: { comment: { content: 'updated' } },
                                                                          headers: { 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
