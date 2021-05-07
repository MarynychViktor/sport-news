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

  after_validation :refresh_picture_on_errors

  def refresh_picture_on_errors
    return if errors.empty?

    if persisted?
      picture.retrieve_from_store!(picture.identifier)
    else
      picture.remove!
      errors.add(:picture, :blank)
    end
  end

  def self.most_popular(max: 3)
    # TODO: add comments and provide
    take(max)
  end

  def self.most_commented(max: 3)
    # TODO: add comments and provide
    take(max)
  end
end
