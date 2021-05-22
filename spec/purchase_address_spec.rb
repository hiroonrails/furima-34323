require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address,user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '商品購入がうまく行くとき' do
      it '全て正しく入力すれば購入可能であること' do
        expect(@purchase_address).to be_valid
      end

      it 'ハイフンのついている郵便番号が必須であること' do
        @purchase_address.postal_code = "115-0098"
        expect(@purchase_address).to be_valid
      end

      it '都道府県の入力が必須であること' do
        @purchase_address.prefecture_id = 4
        expect(@purchase_address).to be_valid
      end

      it '市区町村の入力が必須であること' do
        @purchase_address.address_line1 = "瀬戸内市服部群"
        expect(@purchase_address).to be_valid
      end

      it '番地の入力が必須であること' do
        @purchase_address.address_line2 = "田中6-6-6"
        expect(@purchase_address).to be_valid
      end

      it '11桁以内の数字で入力された電話番号が必須であること' do
        @purchase_address.phone_number = "08000004646"
        expect(@purchase_address).to be_valid
      end

      it '建物名を入力しても登録できること' do
        @purchase_address.bldg_name = "デデデテラス102号室"
        expect(@purchase_address).to be_valid
      end

      it '建物名がなくても登録できること' do
        @purchase_address.bldg_name = ""
        expect(@purchase_address).to be_valid
      end

    end

    context '商品購入がうまく行かないとき' do
      it '郵便番号が空では登録できない' do
        @purchase_address.postal_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと登録できない' do
        @purchase_address.postal_code = "0958843"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '都道府県が空では登録できない' do
        @purchase_address.prefecture_id = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できない' do
        @purchase_address.address_line1 = "" 
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address line1 can't be blank")
      end

      it '番地が空では登録できない' do
        @purchase_address.address_line2 = "" 
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address line2 can't be blank")
      end

      it '電話番号が空では登録できない' do
        @purchase_address.phone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は12桁以上だと登録できない' do
        @purchase_address.phone_number = "000000000000"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid. Must be up to 11 number.")
      end

      it '電話番号にハイフンが入ると登録できない' do
        @purchase_address.phone_number = "080-9906-9433"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid. Must be up to 11 number.")
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      #it 'tokenが空ではできない' do
      #  @purchase_address.token = nil
      #  @purchase_address.valid?
      #  expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      #end

      it '電話番号は英数混合ではできない' do
        @purchase_address.phone_number = "a1111111111"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid. Must be up to 11 number.")
      end

      it '電話番号は９桁以下では登録できない' do
        @purchase_address.phone_number = "333333333"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid. Must be up to 11 number.")
      end

    end
  end
end
