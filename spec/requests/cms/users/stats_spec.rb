require 'rails_helper'

describe '/cms/users/stats' do
  describe 'when user is admin' do
    let(:user) { create(:user, admin: true) }
    before(:each) { sign_in(user) }

    before(:each) do
      2.times { create(:user) }
      2.times { create(:user, admin: true) }
    end

    it 'returns users and admins stats' do
      get stats_cms_users_path, headers: { 'ACCEPT' => 'application/json' }

      body = JSON.parse(response.body)
      expect(body['users_count']).to be(User.users.count)
      expect(body['admins_count']).to be(User.admins.count)
    end
  end
end