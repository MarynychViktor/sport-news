require 'rails_helper'

describe '/cms/users/:id/activate' do
  describe 'when user is admin' do
    let(:current_user) { create(:user, admin: true) }
    let(:admin_user) { create(:user, admin: true) }
    let(:non_admin_user) { create(:user) }
    let(:blocked_user) { create(:user, blocked_at: DateTime.current) }

    before(:each) { sign_in(current_user) }

    it 'activate user' do
      post activate_cms_user_path(blocked_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:ok)
      expect(blocked_user.reload.blocked?).to be_falsey
    end

    it 'forbids to activate admin user' do
      post activate_cms_user_path(admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end

    it 'forbids to activate non user' do
      post activate_cms_user_path(non_admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end
  end
end