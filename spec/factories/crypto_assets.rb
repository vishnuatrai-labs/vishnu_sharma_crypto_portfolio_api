FactoryBot.define do
  factory :crypto_asset do
    name { "Bitcoin" }
    symbol { "bitcoin" }
    quantity { "9.99" }
    purchase_price { "9.99" }
    current_price { "9.99" }
    association :user
  end
end
