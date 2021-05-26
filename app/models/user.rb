# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  blocked_at             :datetime
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  photo                  :string           not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  GOOGLE_PROVIDER = :google_oauth2
  rolify
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [GOOGLE_PROVIDER]
  mount_uploader :photo, PhotoUploader
  has_many :comments

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :photo, presence: true, if: -> { remote_photo_url.present? }
  validates :password, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\-_+!]{8,}\Z/ }

  scope :with_roles, -> { includes(:roles) }
  scope :admins, -> { with_roles.where(roles: { name: 'admin' }) }
  scope :users, -> { with_roles.where.not(roles: { name: 'admin' }).or(with_roles.where(roles: nil)) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    has_role? :admin
  end

  def blocked?
    !!blocked_at
  end

  def block!
    raise AppActionNotAllowedException, 'User already blocked' if blocked?

    self.blocked_at = DateTime.current
    save!(validate: false)
  end

  def activate!
    raise AppActionNotAllowedException, 'User already active' unless blocked?

    self.blocked_at = nil
    save!(validate: false)
  end

  def active_for_authentication?
    super && !blocked?
  end

  def add_admin_role
    raise AppActionNotAllowedException, 'User already admin' if admin?

    add_role :admin unless admin?
  end

  def remove_admin_role
    raise AppActionNotAllowedException, 'User is not in admin role' unless admin?

    remove_role :admin
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
