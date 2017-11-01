FactoryBot.define do
  factory :repair do
    name { FFaker::Product.product }
    user nil
  end
end
