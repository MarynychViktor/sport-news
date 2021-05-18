class Article < ApplicationRecord
  include Elasticsearch::Model
  extend FriendlyId

  friendly_id :headline, use: :slugged
  mount_base64_uploader :picture, PhotoUploader
  attr_accessor :highlighted_headline

  has_many :home_articles, class_name: 'Home::Article', dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :team, optional: true

  scope :with_team_and_categories, -> { includes(:category, :subcategory, :team) }
  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }
  scope :visible, Articles::VisibleQuery

  validates :headline, presence: true, length: { minimum: 10, maximum: 255 }
  validates :alt, :caption, presence: true, length: { minimum: 5, maximum: 255 }
  validates :content, presence: true, length: { minimum: 10, maximum: 4000 }
  validates :picture, :category_id, presence: true
  after_validation :refresh_picture_on_errors

  after_create_commit { ArticleIndexerJob.perform_later(id.to_s) if published? }
  after_update_commit { ArticleIndexerJob.perform_later(id.to_s) }
  after_destroy_commit { ArticleIndexerJob.perform_later(id.to_s) }

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

  # TODO: refactor to query object
  def self.most_popular(max: 3)
    # TODO: add comments and provide
    published.take(max)
  end

  private

  def refresh_picture_on_errors
    return if errors.empty?

    if persisted?
      picture.retrieve_from_store!(picture.identifier)
    else
      picture.remove!
      errors.add(:picture, :blank)
    end
  end
end
