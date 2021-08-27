FactoryBot.define do
  factory :tweet do
    body  { Faker::Lorem.paragraph_by_chars(number: 100, supplemental: false) }

    association :user
    association :memo
  end
end
