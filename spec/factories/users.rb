FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'The Password'

    factory :admin_user, parent: :user do
      after(:create) do |u|
        user.add_role :admin
      end
    end
  end
end
