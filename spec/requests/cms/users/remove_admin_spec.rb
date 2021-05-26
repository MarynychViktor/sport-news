require 'rails_helper'

describe '/cms/users/:id/remove-admin' do
  describe 'when user is admin' do
    let(:current_user) { create(:user, admin: true) }
    let(:admin_user) { create(:user, admin: true) }
    let(:non_admin_user) { create(:user) }
    let(:blocked_user) { create(:user, blocked_at: DateTime.current) }

    before(:each) { sign_in(current_user) }

    it 'remove user from admins' do
      post remove_admin_cms_user_path(admin_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:ok)
      expect(non_admin_user.reload.admin?).to be_falsey
    end

    it 'forbid to remove self from admins' do
      post remove_admin_cms_user_path(current_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end
  end
end