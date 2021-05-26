require 'rails_helper'

describe 'DELETE /cms/users/:id' do
  describe 'when user is admin' do
    let(:current_user) { create(:user, admin: true) }
    let!(:admin_user) { create(:user, admin: true) }
    let!(:non_admin_user) { create(:user) }
    let!(:blocked_user) { create(:user, blocked_at: DateTime.current) }
    let!(:non_admin_user) { create(:user) }

    before(:each) { sign_in(current_user) }

    it 'deletes user' do
      expect {
        delete cms_user_path(non_admin_user), headers: { 'ACCEPT' => 'application/json' }
      }.to change { User.count }.by(-1)
    end

    it 'deletes admins' do
      expect {
        delete cms_user_path(admin_user), headers: { 'ACCEPT' => 'application/json' }
      }.to change { User.count }.by(-1)
    end

    it 'forbids to delete current_user' do
      delete cms_user_path(current_user), headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:forbidden)
    end
  end
end