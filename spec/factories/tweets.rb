FactoryBot.define do
  factory :tweet do
    body  { '本日はとても良い１日で筋トレができました' }

    association :user
    association :memo
  end
end
