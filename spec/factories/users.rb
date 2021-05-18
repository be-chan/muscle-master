FactoryBot.define do
  factory :user do
    nickname              { 'mascleマン' }
    email                 { 'test@test.com' }
    password              { '12345a' }
    password_confirmation  { password }
    introduction           { '私の名前はmascleマンです。よろしくお願いします！' }

    after(:build) do |user|
      user.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
