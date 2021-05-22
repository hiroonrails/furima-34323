FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    name                  { gimei }
    email                 { Faker::Internet.free_email }
    password              { "1a#{Faker::Internet.password(min_length: 6)}" }
    password_confirmation { password }
    kanji_first           { gimei.first }
    kanji_last            { gimei.last }
    kana_first            { gimei.last.katakana }
    kana_last             { gimei.first.katakana }
    birth_date            { Faker::Date.backward }
  end
end
