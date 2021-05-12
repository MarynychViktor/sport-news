FactoryBot.define do
  factory :user do
    transient do
      admin { false }
    end

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { 'secret123' }
    confirmed_at { Date.new }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files', 'test.jpeg'), 'image/jpeg') }

    after(:create) do |user, evaluator|
      user.add_role :admin if evaluator.admin
    end
  end
end
