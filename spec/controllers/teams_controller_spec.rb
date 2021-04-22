require 'rails_helper'

describe TeamsController do
  fixtures :categories
  fixtures :teams
  let(:category) { categories(:category1) }
  let(:fetch_teams) { ->(category) { Team.where(category_id: category.id) } }
  let(:fetch_team) { ->(id) { Team.find_by_id(id) } }

  describe 'GET index' do
    it 'list all teams for given category' do
      count = Team.where(category_id: category.id).count
      get :index, params: { category_id: category.id }

      categories = JSON.parse(response.body)
      expect(categories.count).to be(count)
    end
  end

  describe 'POST create' do
    it 'creates a team with given name for given category' do
      count = fetch_teams.call(category).count
      name = "Team created #{Time.now.to_i}"

      post :create, params: { category_id: category.id, name: name }

      team = JSON.parse response.body

      expect(response.status).to be(200)
      expect(fetch_teams.call(category).count).to be(count + 1)
      expect(team['name']).to eq(name)
    end

    it 'returns error response when name missed' do
      count = fetch_teams.call(category).count

      post :create, params: { category_id: category.id }

      expect(response.status).to be(400)
      expect(fetch_teams.call(category).count).to be(count)
      expect(response.body).to include({ name: ['is missing'] }.to_json)
    end

    it 'returns error response when name shorter than 2 characters' do
      count = fetch_teams.call(category).count

      post :create, params: { category_id: category.id, name: 'A' }

      expect(response.status).to be(400)
      expect(fetch_teams.call(category).count).to be(count)
      expect(response.body).to include('length must be')
    end

    it 'returns error response when name longer than 50 characters' do
      count = fetch_teams.call(category).count
      name = '1' * 51

      post :create, params: { category_id: category.id, name: name }

      expect(response.status).to be(400)
      expect(fetch_teams.call(category).count).to be(count)
      expect(response.body).to include('length must be')
    end
  end

  describe 'PATCH team' do
    let(:team1) { teams(:team1) }
    let(:team2) { teams(:team2) }

    it 'with hidden true makes team hidden' do
      expect(fetch_team.call(team1.id).hidden).to be(false)

      patch :update, params: { id: team1.id, category_id: category.id, hidden: true }

      expect(fetch_team.call(team1.id).reload.hidden).to be(true)
    end

    it 'with hidden false makes team visible' do
      expect(fetch_team.call(team2.id).hidden).to be(true)

      patch :update, params: { id: team2.id, category_id: category.id, hidden: false }

      expect(fetch_team.call(team2.id).reload.hidden).to be(false)
    end
  end

  describe 'DELETE teams' do
    let(:team) { teams(:team1) }

    it 'deletes team' do
      expect(fetch_team.call(team.id)).not_to be(nil)

      patch :destroy, params: { id: team.id, category_id: category.id }

      expect(fetch_team.call(team.id)).to be(nil)
    end
  end
end
