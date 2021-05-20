class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :address_line1, :address_line2, :bldg_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :address_line1
    validates :address_line2
    validates :phone_number, format: {with: /\A\d{11}\z/, message: "is invalid. Must be 11 number."}
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, address_line1: address_line1, address_line2: address_line2, bldg_name: bldg_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end