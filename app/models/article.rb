class Article < ApplicationRecord
  validates :conference, presence: true
  validates :team, presence: true
  validates :caption, presence: true
  validates :alt, presence: true
  validates :picture, presence: true

#  TODO: add uploader to S3
end
