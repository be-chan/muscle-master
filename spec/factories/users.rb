FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 3) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation  { password }
    introduction           { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
