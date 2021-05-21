require 'rails_helper'

describe 'POST /articles/:article_id/comments', type: :request, comments: true, create: true do
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
    context 'with invalid data' do
      let(:user) { create(:user) }
      let(:article) { create(:article, published_at: DateTime.current) }
      before(:each) { sign_in(user) }

      it 'renders errors response when content too short' do
        post article_comments_path(article), params: { comment: { content: '' } },
                                             headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:bad_request)
        expect(body).to have_key('content')
      end

      it 'renders errors response when content too long' do
        post article_comments_path(article), params: { comment: { content: 't'*256 } },
                                             headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:bad_request)
        expect(body).to have_key('content')
      end
    end

    context 'with valid data' do
      let(:user) { create(:user) }
      let(:article) { create(:article, published_at: DateTime.current) }
      let(:comment) { create(:comment, article: article) }
      let(:reply_comment) { create(:comment, article: article, parent: comment) }
      let(:comment_attributes) { attributes_for(:comment) }
      before(:each) { sign_in(user) }

      it 'creates comment' do
        count = article.comments.count

        post article_comments_path(article.id), params: { comment: comment_attributes },
                                                headers: { 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:success)
        expect(article.comments.count).to be(count + 1)
      end

      it 'creates reply to root comment' do
        post article_comments_path(article), params: { comment: { content: 'test', parent_id: comment.id } },
                                             headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(body['parent_id']).to be(comment.id)
        expect(body['thread_id']).to be(comment.id)
      end

      it 'creates reply to another reply comment' do
        post article_comments_path(article), params: { comment: { content: 'test', parent_id: reply_comment.id } },
                                             headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(body['parent_id']).to be(reply_comment.id)
        expect(body['thread_id']).to be(reply_comment.thread_id)
      end
    end
  end
end
