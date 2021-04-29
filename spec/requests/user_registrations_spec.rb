require 'rails_helper'

describe 'UserRegistrations', type: :request do
  fixtures :users

  describe 'GET /users/sign_up' do
    let(:user) { users(:confirmed_customer) }

    it 'renders registration template for non logged in user' do
      get new_user_registration_path

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

    it 'redirects logged in user to home page' do
      sign_in user

      get new_user_registration_path

      expect(response).to redirect_to('/')
    end
  end

  describe 'POST /users' do
    let(:user) { users(:confirmed_customer) }

    it 'registers user and send confirmation email' do
      post user_registration_path, params: { user: { first_name: 'John', last_name: 'Smith', email: 'user@email.com', password: 'secret123', password_confirmation: 'secret123', photo: fixture_file_upload('test.jpeg', 'image/jpeg')} }

      expect(response).to redirect_to('/')
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.length).to eq 1
    end

    it 'renders registration page with errors' do
      post user_registration_path, params: { user: { first_name: 'John', last_name: 'Smith', email: 'useemail.com'} }

      expect(response).to render_template(:new)
      expect(response.body).to include('Please enter valid email')
      expect(response.body).to include('Password is required')
    end

    it 'redirects logged in user to home page' do
      sign_in user

      post user_registration_path

      expect(response).to redirect_to('/')
    end
  end
end
