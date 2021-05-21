module Users
  class ResolveOauthUserService
    include Callable

    def initialize(provider, uid, user_data)
      @provider = provider
      @uid = uid
      @user_data = user_data
    end

    def call
      @user = User.where(provider: @provider, uid: @uid).first_or_initialize.tap do |u|
        u.first_name = @user_data[:first_name]
        u.last_name = @user_data[:last_name]
        u.email = @user_data[:email]
        u.password ||= Devise.friendly_token[0, 20]
        u.confirmed_at ||= DateTime.current
      end
      add_user_photo
      @user.save!
      @user
    end

    private

    def add_user_photo
      return if @user.photo.present?
      return @user.remote_photo_url = @user_data[:image] if @user_data[:image]

      @user.photo = fallback_image
    end

    FALLBACK_IMAGE_ASSET_PATH = 'images/common/user-photo.png'.freeze

    def fallback_image
      File.open(Rails.root.join('app/assets', FALLBACK_IMAGE_ASSET_PATH))
    end
  end
end
