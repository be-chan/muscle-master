FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 3) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation  { password }
    introduction           { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
