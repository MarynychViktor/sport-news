module Home
  class PhotoOfTheDay < ApplicationRecord
    mount_base64_uploader :image, PhotoUploader

    validates :image, :alt, :title, :description, :author, :show, presence: true

    def self.instance
      first_or_initialize
    end
  end
end
