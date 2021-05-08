class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  with_options presence: true do
    validates :name
    validates :password, format: { with: REGEX, message: 'は6文字以上の半角英数字が使えます' }
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は、全角(ひらがな、カタカナ、漢字)の文字を使用してください' } do
      validates :kanji_first
      validates :kanji_last
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナの文字を使用してください' } do
      validates :kana_first
      validates :kana_last
    end
    validates :birth_date
  end
end
