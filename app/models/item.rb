class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :prefecture
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :shipment_day
  has_one_attached :image

  REGEX = /\A([1-9]\d*,)*[1-9]\d*\z/
  with_options presence: true do
    validates :item_name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    with_options numericality: { other_than: 0, message: "を入力してください" } do
      validates :category_id
      validates :status_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :shipment_day_id
    end
    with_options format: { with: REGEX, message: 'は半角数字が使えます' } do
      validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300円以上、9,999,999円以下で入力してください' }
    end
    validates :image
  end
end
