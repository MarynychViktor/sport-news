require 'rails_helper'

describe '/cms/users/:id/add-admin' do
  describe 'when user is admin' do
    let(:current_user) { create(:user, admin: true) }
    let(:admin_user) { create(:user, admin: true) }
    let(:non_admin_user) { create(:user) }
    let(:blocked_user) { create(:user, blocked_at: DateTime.current) }

    before(:each) { sign_in(current_user) }

    it 'adds user to admin' do
      post add_admin_cms_user_path(non_admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:ok)
      expect(non_admin_user.reload.admin?).to be_truthy
    end

    it 'forbid to add admin user to admins' do
      post add_admin_cms_user_path(admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end
  end
end