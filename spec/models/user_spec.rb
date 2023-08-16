require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'ニックネームとEメール、パスワードとパスワード（確認用）が存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it '苗字(全角)に正しい値を代入すれば登録できる' do
        @user.zen_lastname = '山田'
        expect(@user).to be_valid
      end

      it '名前(全角)に正しい値を代入すれば登録できる' do
        @user.zen_firstname = '陸太郎'
        expect(@user).to be_valid
      end

      it '苗字(カナ)に正しい値を代入すれば登録できる' do
        @user.kana_lastname = 'ヤマダ'
        expect(@user).to be_valid
      end

      it '名前(カナ)に正しい値を代入すれば登録できる' do
        @user.kana_firstname = 'リクタロ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'Eメールが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードとパスワード（確認用）が不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '苗字(全角)が空では登録できない' do
        @user.zen_lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角)を入力してください")
      end

      it '苗字が全角でなければ登録できない' do
        @user.zen_lastname = 'Yamada'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('苗字(全角)は不正な値です')
      end

      it '名前(全角)が空では登録できない' do
        @user.zen_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)を入力してください")
      end
      it '名前が全角でなければ登録できない' do
        @user.zen_firstname = 'Rikutaro'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('名前(全角)は不正な値です')
      end

      it '苗字(カナ)が空では登録できない' do
        @user.kana_lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください")
      end
      it '苗字が全角カナでなければ登録できない' do
        @user.kana_lastname = 'ﾔﾏﾀﾞ'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end

      it '名前(カナ)が空では登録できない' do
        @user.kana_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it '名前が全角カナでなければ登録できない' do
        @user.kana_firstname = 'ﾘｸﾀﾛ'
        expect(@user).not_to be_valid
        expect(@user.errors.full_messages).to include('名前(カナ)は不正な値です')
      end

      it '誕生日が空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end

      it '重複したEメールが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'Eメールは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは不正な値です")
      end
      it 'パスワードが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
    end
  end
end
