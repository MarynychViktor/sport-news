class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :headline, use: :slugged

  validates :conference, presence: true
  validates :team, presence: true
  validates :location, presence: true
  validates :headline, presence: true
  validates :alt, presence: true
  validates :caption, presence: true
  validates :content, presence: true
  validates :picture, presence: true

  #  TODO: add uploader to S3
end
