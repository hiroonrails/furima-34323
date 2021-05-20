class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :address_line1, :address_line2, :bldg_name, :phone_number, :user_id, :item_id, :purchase_id

  # ここにバリデーションの処理を書く

  def save
    # 各テーブルにデータを保存する処理を書く
  end
end