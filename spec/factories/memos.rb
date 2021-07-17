FactoryBot.define do
  factory :memo do
    start_time { '2020/01/01' }
    training_content { 'スクワット' }
    weight { 120 }
    training_time { 3 }
    set_count_id { 1 }

    association :user
  end
end
