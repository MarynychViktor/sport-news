FactoryBot.define do
  factory :comment do
    transient do
      thread { nil }
      parent { nil }
      article { nil }
    end

    content { Faker::Lorem.paragraph(sentence_count: 2) }
    user
    # for_article
    #
    # trait :for_article do
    #   association :commentable, factory: :article
    # end

    after(:build) do |comment, evaluator|
      if evaluator.parent
        comment.parent = evaluator.parent
        comment.thread = evaluator.parent.thread || evaluator.parent
      end

      if evaluator.article
        comment.commentable = evaluator.article
      end
    end
  end
end
