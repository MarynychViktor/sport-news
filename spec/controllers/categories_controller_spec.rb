require 'rails_helper'

describe CategoriesController do
  fixtures :categories
  let(:fetch_category) { ->(id) { Category.find_by_id(id) } }

  describe 'GET index' do
    it 'list all categories' do
      count = Category.root_categories.count

      get :index

      categories = JSON.parse(response.body)
      expect(categories.count).to be(count)
    end

    it 'returns error response when name missed' do
      count = Category.count

      post :create

      expect(response.status).to be(400)
      expect(Category.count).to be(count)
      expect(response.body).to include({ name: ['is missing'] }.to_json)
    end
  end

  describe 'GET subcategories' do
    let(:team) { categories :category1 }

    it 'list all subcategories for given category' do
      count = team.children.count

      get :subcategories, params: { category_id: team }

      categories = JSON.parse(response.body)
      expect(categories.count).to be(count)
    end
  end

  describe 'POST categories' do
    it 'creates a category with given name' do
      count = Category.count
      name = "Category created #{Time.now.to_i}"

      post :create, params: { name: name }

      category = JSON.parse response.body

      expect(response.status).to be(200)
      expect(Category.count).to be(count + 1)
      expect(category['name']).to eq(name)
    end

    it 'returns error response when name missed' do
      count = Category.count

      post :create

      expect(response.status).to be(400)
      expect(Category.count).to be(count)
      expect(response.body).to include({ name: ['is missing'] }.to_json)
    end
  end

  describe 'POST subcategories' do
    let(:team) { categories :category1 }

    it 'create subcategory for given category' do
      name = "Subcategory #{Time.now.to_i}"

      post :create_subcategory, params: { category_id: team, name: name }

      subcategory = JSON.parse(response.body)
      expect(subcategory['parent_id']).to be(team.id)
      expect(subcategory['name']).to eq(name)
    end
  end

  describe 'PATCH categories' do
    let(:hidden_category) { categories(:category1) }
    let(:visible_category) { categories(:category2) }

    it 'with hidden true makes category hidden' do
      expect(fetch_category.call(visible_category.id).reload.hidden).to be(false)

      patch :update, params: { id: visible_category.id, hidden: true }

      expect(fetch_category.call(visible_category.id).reload.hidden).to be(true)
    end

    it 'with hidden false makes category visible' do
      expect(fetch_category.call(hidden_category.id).hidden).to be(true)

      patch :update, params: { id: hidden_category.id, hidden: false }

      expect(fetch_category.call(hidden_category.id).reload.hidden).to be(false)
    end
  end

  describe 'DELETE categories' do
    let(:team) { categories(:category1) }

    it 'deletes category' do
      expect(fetch_category.call(team.id)).not_to be(nil)

      patch :destroy, params: { id: team.id }

      expect(fetch_category.call(team.id)).to be(nil)
    end
  end
end
