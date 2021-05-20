class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :address_line1, :address_line2, :bldg_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :address_line1
    validates :address_line2
    validates :bldg_name
    validates :phone_number
    validates :user_id
    validates :item_id
  end

  def save
    :purchase_id
  end
end