module Home
  class PhotoOfTheDay < ApplicationRecord
    mount_base64_uploader :image, PhotoUploader

    validates :image, :alt, :title, :description, :author, presence: true
    validates :alt, :title, :description, :author, presence: true, length: { maximum: 255 }
    validates_inclusion_of :show, in: [true, false]
  end
end
