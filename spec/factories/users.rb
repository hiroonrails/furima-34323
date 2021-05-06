FactoryBot.define do
  factory :user do
    transient do
      person{Gimei.name}
    end
    name                  {Faker::JapaneseMedia::StudioGhibli.character}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    kanji_first           {person.first.kanji}
    kanji_last            {person.last.kanji}
    kana_first            {person.first.katakana}
    kana_last             {person.last.katakana}
    birth_date            {Faker::Date.backward}
  end
end