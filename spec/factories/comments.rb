FactoryBot.define do
  factory :comment do
    body { 'お疲れ様でした。とても良い１日になりましたね！' }

    association :user
    association :tweet
  end
end
