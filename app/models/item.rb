class Item < ApplicationRecord
  with_options presence: true do
    validates :item_name
    validates :explanation
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :shipment_day_id
    validates :price
    validates :image
  end
end
