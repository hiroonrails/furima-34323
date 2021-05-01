class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :name, presence: true
         validates :encrypted_password, presence: true
         validates :kanji_first, presence: true
         validates :kanji_last, presence: true
         validates :kana_first, presence: true
         validates :kana_last, presence: true
         validates :birth_date, presence: true
end
