class Article < ApplicationRecord
  include Elasticsearch::Model
  extend FriendlyId

  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :team, optional: true

  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }

  validates :headline, presence: true
  validates :alt, presence: true
  validates :caption, presence: true
  validates :content, presence: true
  validates :picture, presence: true
  after_validation :refresh_picture_on_errors

  friendly_id :headline, use: :slugged
  mount_base64_uploader :picture, PhotoUploader

  default_scope { includes(:category).order(updated_at: :desc) }

  def refresh_picture_on_errors
    return if errors.empty?

    if persisted?
      picture.retrieve_from_store!(picture.identifier)
    else
      picture.remove!
      errors.add(:picture, :blank)
    end
  end

  def published?
    !!published_at
  end

  def publish
    return if published?

    update!(published_at: DateTime.current)
  end

  def unpublish
    return unless published?

    update!(published_at: nil)
  end

  def self.from_query(params)
    where_params = params.fetch(:where, {})
    scopes = params.fetch(:scopes, [])
    scopes.reduce(self) { |res, n| res.send(n) }.where(where_params)
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
