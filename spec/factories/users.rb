# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password "The Password"

    factory :admin_user, parent: :user do
      after(:create) do |user|
        user.add_role :admin
      end
    end
  end
end
