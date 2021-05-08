require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品がうまく行くとき' do
      it '商品画像を1枚つけることが必須であること' do
        expect(@item).to be_valid
      end

      it '40文字以内の商品名が必須であること' do
        @item.item_name = 'lemon'
        expect(@item).to be_valid
      end

      it '1000文字以内の商品の説明が必須であること' do
        @item.explanation = 'これは本当にすごいんだぞ！'
        expect(@item).to be_valid
      end

      it '商品の状態についての情報が必須であることと' do
        @item.status_id = 5
        expect(@item).to be_valid
      end

      it '配送料の負担についての情報が必須であること' do
        @item.delivery_fee_id = 6
        expect(@item).to be_valid
      end

      it '発送元の地域についての情報が必須であること' do
        @item.prefecture_id = 7
        expect(@item).to be_valid
      end

      it '発送までの日数についての情報が必須であること' do
        @item.shipment_day_id = 1
        expect(@item).to be_valid
      end

      it '¥300~¥9,999,999の販売価格が必須であること' do
        @item.price = 450
        expect(@item).to be_valid
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = 1000
        expect(@item).to be_valid
      end
    end

    context '新規登録がうまく行かないとき' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品の説明が空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it '商品の状態が空では登録できない' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '商品の状態が0では登録できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status を入力してください")
      end

      it '配送料の負担が空では登録できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end

      it '配送料の負担が0では登録できない' do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee を入力してください")
      end

      it '発送元の地域が空では登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域が0では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を入力してください")
      end

      it '発送までの日数が空では登録できない' do
        @item.shipment_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment day can't be blank")
      end

      it '発送までの日数が0では登録できない' do
        @item.shipment_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment day を入力してください")
      end

      it '販売価格が空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が300より小さい数字では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300円以上、9,999,999円以下で入力してください")
      end

      it '販売価格が9999999より大きい数字では登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300円以上、9,999,999円以下で入力してください")
      end

      it '販売価格は半角数字でないと登録できない' do
        @item.price = '１１１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字が使えます")
      end

      it '販売価格は半角英数字混合だと登録できない' do
        @item.price = '3200yen'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300円以上、9,999,999円以下で入力してください")
      end

      it '販売価格は半角英字だと登録できない' do
        @item.price = 'twothousand'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字が使えます")
      end

    end
  end
end
