FactoryBot.define do
  #
  # factory :team do
  #   name { Faker::Name.unique.name }
  #   hidden { false }
  #   subcategory
  # end
  # factory :subcategory do
  #   name { Faker::Name.unique.name }
  #   hidden { false }
  #   category
  # end

  factory :article do
    headline { Faker::Lorem.paragraph(sentence_count: 3) }
    alt { Faker::Lorem.paragraph(sentence_count: 1) }
    location { Faker::Lorem.paragraph(sentence_count: 1) }
    caption { Faker::Lorem.paragraph(sentence_count: 1) }
    content { Faker::Lorem.paragraph(sentence_count: 50) }
    # picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files', 'test.jpeg'), 'image/jpeg') }
    remote_picture_url { Faker::LoremFlickr.image(size: "1280x1024") }
    category
    subcategory
    team
  end
end
# params.require(:article).permit(:conference, :subcategory_id, :team_id, :picture, :caption, :alt, :location,
#                                 :headline, :content, :display_comments)