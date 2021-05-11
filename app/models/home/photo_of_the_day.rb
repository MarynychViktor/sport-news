module Home
  class PhotoOfTheDay < ApplicationRecord
    mount_base64_uploader :image, PhotoUploader

    validates :image, :alt, :title, :description, :author, presence: true
    validates_inclusion_of :show, in: [true, false]

    def self.instance
      first
    end

    def self.instance_or_new
      instance || new
    end
  end
end
