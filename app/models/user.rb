class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # with_options使って中身を記載すると全部に適用される。
         VALID_REGEX = /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/
        with_options presence: true do
          validates :name
          #このオプションは使える。format: { with: REGEX(正規表現) , message "表示したいこと"}
          validates :password, format: { with: VALID_REGEX , message: "は6文字以上の英数字が使えます" }
          # with_optionsもわんちゃん入れ子構造になるかもしれん
          with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
            validates :kanji_first
            validates :kanji_last
            validates :kana_first
            validates :kana_last
          end
          validates :birth_date
        end
end