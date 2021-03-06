FactoryBot.define do
  factory :purchase_address do
    address = Gimei.address
    postal_code          { "111-1111" }
    prefecture_id        { Faker::Number.between(from: 1, to: 48) }
    address_line1        { address.city.to_s }
    address_line2        { "田中5-5-5" }
    bldg_name            { "ガーラ渋谷常盤末 303号室" }
    phone_number         { Faker::Number.number(digits: 11) }
    price {3000}
    token {"tok_abcdefghijk00000000000000000"}
  end
end