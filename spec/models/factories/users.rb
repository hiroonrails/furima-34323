FactoryBot.define do
  factory :user do
    transient do
      person{Gimei.name}
    end
    name                  {Faker::JapaneseMedia::StudioGhibli.character}
    email                 {FAKER::Internet.free_email}
    password              {FAKER::Internet.password(min_length: 6)}
    password_confirmation {password}
    kanji_first           {person.first.kanji}
    kanji_last            {person.last.kanji}
    kana_first            {person.first.kana}
    kana_last             {person.last.kana}
    birth_date            {FAKER::Date.backward}
  end
end