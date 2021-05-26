require 'rails_helper'

describe '/cms/users' do
  describe 'when user is admin' do
    let(:user) { create(:user, admin: true) }
    before(:each) { sign_in(user) }

    before(:each) do
      2.times { create(:user) }
      2.times { create(:user, admin: true) }
    end

    it 'returns paginated response' do
      get cms_users_path, headers: { 'ACCEPT' => 'application/json' }

      body = JSON.parse(response.body)
      expect(body).to have_key('last_page')
      expect(body).to have_key('page')
      expect(body).to have_key('total')
      expect(body).to have_key('data')
    end

    it 'returns all users' do
      get cms_users_path, headers: { 'ACCEPT' => 'application/json' }

      body = JSON.parse(response.body)
      expect(body['data'].count).to be(5)
    end

    it 'returns admin users' do
      get cms_users_path, params: {role: 'admin'}, headers: { 'ACCEPT' => 'application/json' }

      users = JSON.parse(response.body)['data']
      expect(users.count).to be(3)
      expect(users.map {|u| u['admin'] }).to all(be_truthy)
    end

    it 'returns non admin users' do
      get cms_users_path, params: {role: 'user'}, headers: { 'ACCEPT' => 'application/json' }

      users = JSON.parse(response.body)['data']
      expect(users.count).to be(2)
      expect(users.map {|u| u['admin'] }).to all(be_falsy)
    end
  end
end