# frozen_string_literal: true
module CMS
  class UsersController < ApplicationController
    before_action :find_user, except: %i[index stats]
    before_action :authorize_user, except: %i[index stats]

    def index
      respond_to do |format|
        format.json do
          users = Users::ListQuery.call(params[:role])
          @result = paginate(users)
        end
        format.html
      end
    end

    def stats
      render json: { users_count: User.users.count, admins_count: User.admins.count }
    end

    def block
      @user.block!
      head :ok
    end

    def activate
      @user.activate!
      head :ok
    end

    def add_admin
      @user.add_admin_role
      head :ok
    end

    def remove_admin
      @user.remove_admin_role
      head :ok
    end

    def destroy
      @user.destroy!
      head :ok
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def authorize_user
      authorize @user
    end
  end
end
