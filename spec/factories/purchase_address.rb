FactoryBot.define do
  factory :purchase_address do
    address = Gimei.address
    postal_code          { "111-1111" }
    prefecture_id        { Faker::Number.between(from: 1, to: 48) }
    address_line1        { address.city.to_s }
    address_line2        { "田中5-5-5" }
    phone_number         { Faker::Number.number(digits: 11) }
  end
end