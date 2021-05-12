class Article < ApplicationRecord
  include Elasticsearch::Model
  extend FriendlyId

  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :team, optional: true

  friendly_id :headline, use: :slugged
  mount_base64_uploader :picture, PhotoUploader
  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }
  default_scope { includes(:category).order(updated_at: :desc) }

  has_many :home_articles, class_name: 'Home::Article', dependent: :destroy

  validates :headline, presence: true
  validates :alt, presence: true
  validates :caption, presence: true
  validates :content, presence: true
  validates :picture, presence: true
  after_validation :refresh_picture_on_errors

  after_save    { ArticleIndexerJob.perform_later(:index, id) }
  after_destroy { ArticleIndexerJob.perform_later(:destroy, id) }

  attr_accessor :highlighted_headline

  # TODO: add search service and put ES specific logic there
  def self.search_by_title_and_content(query, page: 1, limit: 10)
    result = search(query: {
                      multi_match: {
                        query: query,
                        # fuzziness: 1,
                        fields: ['headline']
                      }
                    },
                    highlight: {
                      tags_schema: "styled",
                      fields: {
                        headline: {}
                      }
                    },
                    _source: ['_id'],
                    size: limit,
                    from: (page - 1) * limit
    )
    total = result.response[:hits][:total][:value]
    data = result.results.map do |res|
      record = find(res[:_id])
      record.highlighted_headline = res[:highlight][:headline].join(' ')
      record
    end
    { data: data, total: total, page: page, last_page: page * limit >= total }
  end

  def as_indexed_json(options = {})
    content = as_json(only: %i[id location headline content])
    content['content'] = ActionController::Base.helpers.strip_tags(content['content'].gsub('><', '> <')).strip
    content
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
