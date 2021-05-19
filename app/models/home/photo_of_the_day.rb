# == Schema Information
#
# Table name: home_photo_of_the_days
#
#  id          :bigint           not null, primary key
#  alt         :string           not null
#  author      :string           not null
#  description :string           not null
#  image       :string           not null
#  show        :boolean          default(TRUE), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Home
  class PhotoOfTheDay < ApplicationRecord
    mount_base64_uploader :image, PhotoUploader

    validates :image, :alt, :title, :description, :author, presence: true
    validates :alt, :title, :description, :author, presence: true, length: { maximum: 255 }
    validates_inclusion_of :show, in: [true, false]
  end
end
