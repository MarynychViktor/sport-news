class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  mount_uploader :photo, PhotoUploader

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :photo, presence: true
  validates :password, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\-_+!]{8,}\Z/}

  def full_name
    "#{first_name} #{last_name}"
  end
end
