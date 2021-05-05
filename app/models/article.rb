class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :headline, use: :slugged
  mount_base64_uploader :picture, PhotoUploader

  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :team, optional: true

  validates :headline, presence: true
  validates :alt, presence: true
  validates :caption, presence: true
  validates :content, presence: true
  validates :picture, presence: true

  default_scope { order(updated_at: :desc) }
  #  TODO: add uploader to S3
end
