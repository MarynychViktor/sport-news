# == Schema Information
#
# Table name: articles
#
#  id               :bigint           not null, primary key
#  alt              :string
#  caption          :string
#  content          :text
#  display_comments :boolean          default(TRUE), not null
#  headline         :string
#  location         :string
#  picture          :string           not null
#  published_at     :datetime
#  slug             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :bigint           not null
#  subcategory_id   :bigint
#  team_id          :bigint
#
# Indexes
#
#  index_articles_on_category_id     (category_id)
#  index_articles_on_slug            (slug) UNIQUE
#  index_articles_on_subcategory_id  (subcategory_id)
#  index_articles_on_team_id         (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (subcategory_id => subcategories.id)
#  fk_rails_...  (team_id => teams.id)
#
class Article < ApplicationRecord
  include Elasticsearch::Model
  extend FriendlyId
  extend Mobility

  MOST_POPULAR_RESULTS_COUNT = 3
  TRENDING_ARTICLES_COUNT = 4

  translates :headline, :alt, :caption, type: :string
  translates :content, type: :text

  friendly_id :headline, use: :slugged
  mount_base64_uploader :picture, PhotoUploader
  attr_accessor :highlighted_headline

  has_many :home_articles, class_name: 'Home::Article', dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :locations
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
  validates_length_of :locations, maximum: 1
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

  def location
    locations.first
  end

  def self.most_popular
    # TODO: add logic to track popularity
    published.take(MOST_POPULAR_RESULTS_COUNT)
  end

  def self.hero
    # TODO: add logic to select hero article
    take(1)
  end

  def self.trending
    # TODO: add logic to select trending articles
    take(TRENDING_ARTICLES_COUNT)
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
