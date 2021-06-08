require 'rails_helper'

describe 'UserPasswords', type: :request do
  fixtures :users

  describe 'GET  /users/password/new' do
    let(:user) { users(:confirmed_customer) }

    it 'renders forgot-password template for non logged in user' do
      get new_user_password_path

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response.body).to include('Forgot your password?')
    end

    it 'redirects to root page when user already logged in' do
      sign_in user

      get new_user_password_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST  /users/password' do
    let(:user) { users(:confirmed_customer) }

    it 'sends reset instructions email' do
      post user_password_path, params: { user: { email: user.email } }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:sent)
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.length).to eq 1
    end

    it 'renders success response but don\'t send instructions on non-existent email' do
      post user_password_path, params: { user: { email: 'nonexistent@email.com' } }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:sent)
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.length).to eq 0
    end

    it 'renders error when provided email is not valid email address' do
      post user_password_path, params: { user: { email: 'not-email-address' } }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response.body).to include('Please provide valid email address')
    end
  end
end
