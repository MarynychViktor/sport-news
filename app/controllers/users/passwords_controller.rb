# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    user_attributes = params.fetch(:user, {})

    unless Devise.email_regexp.match(user_attributes[:email])
      @user = User.new
      @user.errors.add(:email, :email, message: 'Please provide valid email address')

      render :new and return
    end

    @user = User.send_reset_password_instructions(user_attributes)
    render :sent
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected
  #
  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
