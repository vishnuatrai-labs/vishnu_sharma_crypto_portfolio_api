FactoryBot.define do
  factory :crypto_asset do
    name { "MyString" }
    symbol { "MyString" }
    quantity { "9.99" }
    purchase_price { "9.99" }
    current_price { "9.99" }
    user { nil }
  end
end
