FactoryBot.define do
  factory :item do
    image                {}
    item_name            { Faker::Name.name }
    explanation          { Faker::Lorem.sentence }
    category_id          { Faker::Number.between(from: 1, to: 10)}
    status_id            { Faker::Number.between(from: 1, to: 12)}
    delivery_fee_id      { Faker::Number.between(from: 1, to: 2)}
    prefecture_id        { Faker::Number.between(from: 1, to: 48)}
    shipment_day_id      { Faker::Number.between(from: 1, to: 3)}
    price                { Faker::Number.between(from: 300, to: 9999999)}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/vidal_test.png'), filename: 'vidal_test.png')
    end

  end
end
