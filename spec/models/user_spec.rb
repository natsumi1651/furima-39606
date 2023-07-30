require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'zen_lastnameに正しい値を代入すれば登録できる' do
        @user.zen_lastname = '山田'
        expect(@user).to be_valid
      end

      it 'zen_firstnameに正しい値を代入すれば登録できる' do
        @user.zen_firstname = '陸太郎'
        expect(@user).to be_valid
      end

      it 'kana_lastnameに正しい値を代入すれば登録できる' do
        @user.kana_lastname = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'kana_firstnameに正しい値を代入すれば登録できる' do
        @user.kana_firstname = 'リクタロ'
        expect(@user).to be_valid
      end

    end


    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'zen_lastnameが空では登録できない' do
        @user.zen_lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Zen lastname can't be blank")
      end

      it 'zen_lastnameが全角でなければ登録できない' do
        @user.zen_lastname = 'Yamada'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Zen lastname is invalid')
      end

      it 'zen_firstnameが空では登録できない' do
        @user.zen_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Zen firstname can't be blank")
      end
      it 'zen_firstnameが全角でなければ登録できない' do
        @user.zen_firstname = 'Rikutaro'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Zen firstname is invalid')
      end

      it 'kana_lastnameが空では登録できない' do
        @user.kana_lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana lastname can't be blank")
      end
      it 'kana_lastnameが全角カナでなければ登録できない' do
        @user.kana_lastname = 'ﾔﾏﾀﾞ'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Kana lastname is invalid')
      end

      it 'kana_firstnameが空では登録できない' do
        @user.kana_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana firstname can't be blank")
      end
      it 'kana_firstnameが全角カナでなければ登録できない' do
        @user.kana_firstname = 'ﾘｸﾀﾛ'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('Kana firstname is invalid')
      end
      
      it 'birthdayが空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      
      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

    end
  end
end
