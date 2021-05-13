require 'rails_helper'

shared_examples 'renders new form with errors' do |name, invalid_values|
  it "renders :new form with errors when #{name} is not valid" do
    invalid_values.each do |value|
      article_params[name] = value

      post cms_category_articles_path(category), params: { article: article_params }

      expect(response).to render_template(:new)
      expect(response.body).to include("article_#{name} field_with_errors")
    end
  end
end

describe 'POST /cms/categories/:category_id/articles', type: :request, articles: true, create: true do
  context 'when user is admin' do
    let(:user) { create(:user, admin: true) }
    let(:category) { create(:category) }
    before(:each) { sign_in(user) }

    context 'with valid params' do
      let(:article_params) { attributes_for(:article) }

      it 'creates new article' do
        articles_count = Article.count
        post cms_category_articles_path(category), params: { article: article_params }
        expect(Article.count).to be(articles_count + 1)
      end

      it 'redirects to articles list' do
        post cms_category_articles_path(category), params: { article: article_params }
        expect(response).to redirect_to(cms_category_articles_path(category))
      end
    end

    context 'with invalid params' do
      let(:article_params) { attributes_for(:article) }

      include_examples 'renders new form with errors', 'headline', [nil, 'too short', 1 * 256]
      include_examples 'renders new form with errors', 'alt', [nil, 'a' * 4, 1 * 256]
      include_examples 'renders new form with errors', 'caption', [nil, 'a' * 4, 1 * 256]
      include_examples 'renders new form with errors', 'content', [nil, 'a' * 4, 1 * 4000]
      include_examples 'renders new form with errors', 'picture', [nil]
    end
  end
end

describe 'POST /cms/categories/:category_id/articles', type: :request, articles: true, create: true do
  context 'when user is not admin' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    before(:each) { sign_in(user) }
    let(:article_params) { attributes_for(:article) }

    it 'renders forbidden response' do
      post cms_category_articles_path(category), params: { article: article_params }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not create new article' do
      articles_count = Article.count
      post cms_category_articles_path(category), params: { article: article_params }
      expect(Article.count).to be(articles_count)
    end
  end
end
