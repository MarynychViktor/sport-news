# frozen_string_literal: true
module CMS
  class UsersController < ApplicationController
    before_action :find_user, except: %i[index]

    def index
      users = case params[:role]
              when 'admin'
                User.admins
              when 'user'
                User.users
              else
                User.all
              end

      @result = paginate(users)
      respond_to do |format|
        format.json
        format.html
      end
    end

    def block
      @user.block!
    end

    def activate
      @user.activate!
    end

    def add_admin
      @user.add_role :admin
    end

    def remove_admin
      @user.remove_role :admin
    end

    def destroy
      @user.destroy
    end

    private

    def find_user
      @user = User.find(params[:id])
    end
  end
end
