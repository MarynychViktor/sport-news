FactoryBot.define do
  factory :article do
    headline { Faker::Lorem.paragraph(sentence_count: 3) }
    alt { Faker::Lorem.paragraph(sentence_count: 1) }
    location { Faker::Lorem.paragraph(sentence_count: 1) }
    caption { Faker::Lorem.paragraph(sentence_count: 1) }
    content { Faker::Lorem.paragraph(sentence_count: 50) }
    # picture { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files', 'test.jpeg'), 'image/jpeg') }
    remote_picture_url { Faker::LoremFlickr.image(size: "800x600") }
    published_at { nil }
    category
    subcategory
    team
  end
end
