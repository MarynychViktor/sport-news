require 'rails_helper'

describe Article, type: :model, article: true do
  describe '#find_articles_by' do
    let!(:category) { create(:category) }
    let!(:hidden_category) { create(:category, hidden: true) }
    let!(:subcategory) { create(:subcategory, category: category) }
    let!(:hidden_subcategory) { create(:subcategory, hidden: true) }
    let!(:team) { create(:team, subcategory: subcategory) }
    let!(:article1) { create(:article, category: category, subcategory: subcategory) }
    let!(:article2) do
      create(:article, published_at: DateTime.current, category: category, subcategory: subcategory, team: team)
    end
    let!(:article3) { create(:article, category: hidden_category, subcategory: hidden_subcategory) }

    it 'returns all articles with empty query' do
      results = Article.find_articles_by({})
      expect(results.count).to be(3)
      expect(results).to include(article1, article2, article3)
    end

    it 'returns articles for given category' do
        results = Article.find_articles_by({ category_id: hidden_category.id })
        expect(results.count).to be(1)
        expect(results).to include(article3)
    end

    it 'returns articles for given subcategory' do
      results = Article.find_articles_by({ subcategory_id: hidden_subcategory.id })
      expect(results.count).to be(1)
      expect(results).to include(article3)
    end

    it 'returns articles for given team' do
      results = Article.find_articles_by({ team_id: team.id })
      expect(results.count).to be(1)
      expect(results).to include(article2)
    end
  end

  describe '#find_public_articles_by' do
    context 'when ancestors visible' do
      let!(:visible_category) { create(:category) }
      let!(:visible_subcategory) { create(:subcategory, category: visible_category) }
      let!(:visible_team) { create(:team, subcategory: visible_subcategory) }
      let!(:unpublished_article) { create(:article, category: visible_category, subcategory: visible_subcategory) }
      let!(:published_article1) do
        create(:article, published_at: DateTime.current, category: visible_category, subcategory: visible_subcategory)
      end
      let!(:published_article2) do
        create(:article, published_at: DateTime.current, category: visible_category, team: visible_team)
      end
      let!(:other_article) { create(:article) }
      let!(:other_published_article) { create(:article, published_at: DateTime.current) }

      it 'returns all published articles with empty query' do
        results = Article.find_public_articles_by({})
        expect(results.count).to be(3)
        expect(results).to include(published_article1, published_article2, other_published_article)
      end

      it 'returns published articles for given category' do
        results = Article.find_public_articles_by({ category_id: visible_category.id })
        expect(results.count).to be(2)
        expect(results).to include(published_article1, published_article2)
      end

      it 'returns published articles for given subcategory' do
        results = Article.find_public_articles_by({ subcategory_id: visible_subcategory.id })
        expect(results.count).to be(1)
        expect(results).to include(published_article1)
      end

      it 'returns published articles for given team' do
        results = Article.find_public_articles_by({ team_id: visible_team.id })
        expect(results.count).to be(1)
        expect(results).to include(published_article2)
      end
    end

    context 'when any of ancestors hidden' do
      let!(:hidden_category) { create(:category, hidden: true) }
      let!(:hidden_subcategory) { create(:subcategory, hidden: true) }
      let!(:hidden_team) { create(:team, hidden: true) }
      let!(:team_with_hidden_subcategory) { create(:team, subcategory: hidden_subcategory) }

      it 'returns empty results with empty query' do
        results = Article.find_public_articles_by({})
        expect(results.count).to be(0)
      end

      it 'returns empty results with hidden category' do
        results = Article.find_public_articles_by({ category_id: hidden_category.id })
        expect(results.count).to be(0)
      end

      it 'returns empty results with hidden subcategory' do
        results = Article.find_public_articles_by({ subcategory_id: hidden_subcategory.id })
        expect(results.count).to be(0)
      end

      it 'returns empty results with hidden team' do
        results = Article.find_public_articles_by({ team_id: hidden_team.id })
        expect(results.count).to be(0)
      end

      it 'returns empty results with team that has hidden subcategory' do
        results = Article.find_public_articles_by({ team_id: hidden_team.id })
        expect(results.count).to be(0)
      end
    end
  end
end
