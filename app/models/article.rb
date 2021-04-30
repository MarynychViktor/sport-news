class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :headline, use: :slugged
  mount_base64_uploader :picture, PhotoUploader

  validates :headline, presence: true
  validates :alt, presence: true
  validates :caption, presence: true
  validates :content, presence: true
  validates :picture, presence: true

  #  TODO: add uploader to S3
end
