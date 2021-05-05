require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'ニックネームが必須であること' do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
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

  end
end