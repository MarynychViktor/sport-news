require 'rails_helper'

describe 'POST  /articles/:article_id/comments/:id/(like|dislike)', type: :request, comments: true, feedback: true do
  describe 'when user is not logged in' do
    let(:user) { create(:user) }
    let(:article) { create(:article, published_at: DateTime.current) }
    let(:comment) { create(:comment, article: article) }

    it 'receives unauthorized response' do
      post like_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'when user logged in' do
    describe 'when comment dont have user feedbacks' do
      let(:user) { create(:user) }
      let(:article) { create(:article, published_at: DateTime.current) }
      let(:comment) { create(:comment, article: article) }
      before(:each) { sign_in(user) }

      it 'adds like to comment' do
        post like_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(body['likes']).to be(1)
      end

      it 'adds dislike to comment' do
        post dislike_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }

        body = JSON.parse(response.body)
        expect(body['dislikes']).to be(1)
      end
    end

    describe 'when comment already have user feedbacks' do
      context 'with like feedback' do
        let(:user) { create(:user) }
        let(:article) { create(:article, published_at: DateTime.current) }
        let(:comment) { create(:comment, article: article) }
        let!(:feedback) { create(:feedback, comment: comment, user: user, positive: true) }
        before(:each) { sign_in(user) }

        it 'removes feedback on another like attempt' do
          post like_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }

          body = JSON.parse(response.body)
          expect(body['likes']).to be(0)
        end

        it 'changes feedback to negative on dislike attempt' do
          post dislike_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }

          body = JSON.parse(response.body)
          expect(body['likes']).to be(0)
          expect(body['dislikes']).to be(1)
        end
      end

      context 'with dislike feedback' do
        let(:user) { create(:user) }
        let(:article) { create(:article, published_at: DateTime.current) }
        let(:comment) { create(:comment, article: article) }
        let!(:feedback) { create(:feedback, comment: comment, user: user, positive: false) }
        before(:each) { sign_in(user) }

        it 'removes feedback on another dislike attempt' do
          post dislike_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }

          body = JSON.parse(response.body)
          expect(body['dislikes']).to be(0)
        end

        it 'changes feedback to positive on like attempt' do
          post like_article_comment_path(article, comment), headers: { 'ACCEPT' => 'application/json' }

          body = JSON.parse(response.body)
          expect(body['likes']).to be(1)
          expect(body['dislikes']).to be(0)
        end
      end
    end
  end
end