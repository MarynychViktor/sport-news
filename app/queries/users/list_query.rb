module Users
  class ListQuery
    include Callable
    USER_ROLE = :user
    ADMIN_ROLE = :admin

    def initialize(in_role)
      @role = in_role&.to_sym
    end

    def call
      case @role
      when ADMIN_ROLE
        User.admins
      when USER_ROLE
        User.users
      else
        User.all
      end
    end
  end
end
