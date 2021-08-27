FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph_by_chars(number: 100, supplemental: false) }

    association :user
    association :tweet
  end
end
