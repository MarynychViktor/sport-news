require 'rails_helper'

shared_examples 'renders edit form with errors' do |name, invalid_values|
  it "renders :edit form with errors when #{name} is not valid" do
    invalid_values.each do |value|
      article_params[name] = value

      patch cms_category_article_path(article.category, article), params: { article: article_params }

      expect(response).to render_template(:edit)
      expect(response.body).to include("article_#{name} field_with_errors")
    end
  end
end

describe 'PATCH /cms/categories/:category_id/articles/:id', type: :request, articles: true, update: true do
  context 'when user is admin' do
    let(:user) { create(:user, admin: true) }
    let(:article) { create(:article) }
    before(:each) { sign_in(user) }

    context 'with valid params' do
      let(:article_params) { attributes_for(:article) }

      it 'updates article' do
        patch cms_category_article_path(article.category, article), params: { article: article_params }

        expect(Article.find(article.id).headline).not_to eql(article.headline)
        expect(Article.find(article.id).headline).to eql(article_params[:headline])
      end

      it 'redirects to articles list' do
        patch cms_category_article_path(article.category, article), params: { article: article_params }
        expect(response).to redirect_to(cms_category_articles_path(article.category))
      end
    end

    context 'with invalid params' do
      let(:article_params) { attributes_for(:article) }

      include_examples 'renders edit form with errors', 'headline', [nil, 'too short', 1 * 256]
      include_examples 'renders edit form with errors', 'alt', [nil, 'a' * 4, 1 * 256]
      include_examples 'renders edit form with errors', 'caption', [nil, 'a' * 4, 1 * 256]
      include_examples 'renders edit form with errors', 'content', [nil, 'a' * 4, 1 * 4000]
    end
  end
end

describe 'PATCH /cms/categories/:category_id/articles/:id', type: :request, articles: true, update: true do
  context 'when user is not admin' do
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    before(:each) { sign_in(user) }
    let(:article_params) { attributes_for(:article) }

    it 'renders forbidden response' do
      patch cms_category_article_path(article.category, article), params: { article: article_params }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not update article' do
      patch cms_category_article_path(article.category, article), params: { article: article_params }
      expect(Article.find(article.id).headline).to eql(article.headline)
    end
  end
end
