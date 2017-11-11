# frozen_string_literal: true

FactoryBot.define do
  factory :repair do
    name { FFaker::Product.product }
    user
  end
end
