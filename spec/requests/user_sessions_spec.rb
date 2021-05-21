require 'rails_helper'

describe 'UserSessions', type: :request do
  fixtures :users

  describe 'GET /users/sign_in' do
    let(:user) { users(:confirmed_customer) }

    it 'renders new session template for non logged in user' do
      get new_user_session_path

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

    it 'redirects to root page when user already logged in' do
      sign_in user

      get new_user_session_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST /users/sign_in' do
    let(:user) { users(:confirmed_customer) }
    let(:non_confirmed_user) { users(:customer) }

    it 'creates new session for non logged in user' do
      post new_user_session_path, params: { user: { email: user.email, password: 'secret123' } }

      expect(response).to redirect_to(root_path)
    end

    it 'not creates new session with invalid credentials' do
      post new_user_session_path, params: { user: { email: user.email, password: 'invalid password' } }

      expect(response).to render_template(:new)
      expect(response.body).to include('Incorrect email or password')
    end

    it 'not creates new session with non-confirmed account' do
      post new_user_session_path, params: { user: { email: non_confirmed_user.email, password: 'secret123' } }

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
