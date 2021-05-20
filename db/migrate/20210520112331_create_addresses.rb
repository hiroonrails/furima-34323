class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string      :postal_code,            null: false
      t.integer     :prefecture_id,          null: false
      t.string      :address_line1,          null: false
      t.string      :address_line2,          null: false
      t.string      :bldg_name,              null: false
      t.string      :phone_number,           null: false
      t.references  :purchase,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
