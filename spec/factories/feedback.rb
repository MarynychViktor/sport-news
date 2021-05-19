FactoryBot.define do
  factory :feedback do
    transient do
      comment { nil }
    end

    positive { true }
    user
    for_comment

    trait :for_comment do
      association :feedbackable, factory: :comment
    end

    after(:build) do |comment, evaluator|
      comment.feedbackable = evaluator.comment if evaluator.comment
    end
  end
end
