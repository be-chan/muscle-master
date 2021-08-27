FactoryBot.define do
  factory :like do
    association :user
    association :tweet
  end
end
