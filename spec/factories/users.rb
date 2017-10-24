FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'The Password'
  end
end
