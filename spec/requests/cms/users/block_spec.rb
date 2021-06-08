require 'rails_helper'

describe '/cms/users/:id/block' do
  describe 'when user is admin' do
    let(:current_user) { create(:user, admin: true) }
    let(:admin_user) { create(:user, admin: true) }
    let(:non_admin_user) { create(:user) }
    let(:blocked_user) { create(:user, blocked_at: DateTime.current) }

    before(:each) { sign_in(current_user) }

    it 'blocks user' do
      post block_cms_user_path(non_admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:ok)
      expect(non_admin_user.reload.blocked?).to be_truthy
    end

    it 'forbids to block admin user' do
      post block_cms_user_path(admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end

    it 'forbids to block blocked user' do
      post block_cms_user_path(blocked_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end
  end
end