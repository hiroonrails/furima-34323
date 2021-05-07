require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context "新規登録がうまく行くとき" do
      it 'ユーザーネーム' do
        @user.name = "田中の人"
        expect(@user).to be_valid
      end

      it '全角(漢字の名)' do
        @user.kanji_first = "裕武"
        expect(@user).to be_valid
      end

      it '全角(漢字の姓)' do
        @user.kanji_last = "村山"
        expect(@user).to be_valid
      end

      it '全角(カタカナの名)' do
        @user.kana_first = "ヒロム"
        expect(@user).to be_valid
      end

      it '全角(カタカナの姓)' do
        @user.kana_last = "ムラヤマ"
        expect(@user).to be_valid
      end

      it 'e-mailが登録できる' do
        @user.email = "aaa@aaa"
        expect(@user).to be_valid
      end

      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = "a9a9a9"
        @user.password_confirmation = "a9a9a9"
        expect(@user).to be_valid
      end

      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password = "a6a6a6"
        @user.password_confirmation = "a6a6a6"
        expect(@user).to be_valid
      end

      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password = "aaaaaa6"
        @user.password_confirmation = "aaaaaa6"
        expect(@user).to be_valid
      end

      it '誕生日が入力されている' do
        @user.birth_date = "19961114"
        expect(@user).to be_valid
      end
    end

    context "新規登録がうまく行かないとき" do
      it 'ニックネームが必須であること' do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it '漢字の名は、空では登録できない' do
        @user.kanji_first = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first can't be blank")
      end

      it '漢字の姓は、空では登録できない' do
        @user.kanji_last = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last can't be blank")
      end

      it 'カナの名は、空では登録できない' do
        @user.kana_first = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first can't be blank")
      end

      it 'カナの姓は、空では登録できない' do
        @user.kana_last = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last can't be blank")
      end

      it 'ユーザー本名(漢字)は、全角での入力が必須' do
        @user.kanji_first = "lalaland侍摂政マル"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first 全角漢字の文字を使用してください")
      end

      it 'ユーザー本名(漢字)は、全角での入力が必須' do
        @user.kanji_last = "lalaland侍摂政マル"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last 全角漢字の文字を使用してください")
      end

      it 'ユーザー本名(カナ)は、全角での入力が必須' do
        @user.kana_first = "lalaland侍摂政マル"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first 全角カタカナの文字を使用してください")
      end

      it 'ユーザー本名(カナ)は、全角での入力が必須' do
        @user.kana_last = "lalaland侍摂政マル"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last 全角カタカナの文字を使用してください")
      end

      it 'メールアドレスが必須であること' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_one = FactoryBot.build(:user)
        another_one.email = @user.email
        another_one.valid?
        expect(another_one.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが必須であること' do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = "aaaaa"
        @user.password_confirmation = "aaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードは英字のみでは登録できないこと' do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上の英数字が使えます")
      end

      it 'パスワードは数字のみでは登録できないこと' do
        @user.password = "999999"
        @user.password_confirmation = "999999"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上の英数字が使えます")
      end

      it '誕生日が空では保存できないこと' do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end

  end
end