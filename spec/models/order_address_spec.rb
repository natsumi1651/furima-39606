require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入内容の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'ユーザーと商品名が紐付いていて、郵便番号、都道府県、市町村、番地、電話番号、トークンがあれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end

      
      it '郵便番号が「3桁ハイフン4桁」の形式なら保存できること' do
        valid_post_codes = %w[123-4567 456-7890 001-0010]
        valid_post_codes.each do |post_code|
          @order_address.post_code = post_code
          expect(@order_address).to be_valid
        end
      end

      it '電話番号が10桁以上11桁以内の半角数値なら保存できること' do
        valid_phone_numbers = %w[1234567890 09876543210 12345678901]
        valid_phone_numbers.each do |phone_number|
          @order_address.phone_number = phone_number
          expect(@order_address).to be_valid
        end
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号を入力してください')
      end

      it '郵便番号が「3桁ハイフン4桁」の形式でないと保存できないこと' do
        invalid_post_codes = %w[1234567 12-34567 123-45678 aaa-bbbb]
        invalid_post_codes.each do |post_code|
          @order_address.post_code = post_code
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('郵便番号は、3または4桁でないといけません')
        end
      end

      it '都道府県がid: 1だと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県は空欄にはできません。")
      end

      it '市町村が空だと保存できないこと' do
        @order_address.town = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市町村を入力してください")
      end

      it '番地が空だと保存できないこと' do
        @order_address.block_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号が空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号が10桁以上11桁以内の半角数値でないと保存できないこと' do
          @order_address.phone_number = 123456789
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('電話番号は、10または11桁でないといけません。')
      end

      it '電話番号が10桁以上11桁以内の半角数値でないと保存できないこと' do
          @order_address.phone_number = 123456789012
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('電話番号は、10または11桁でないといけません。')
      end

      it '電話番号が10桁以上11桁以内の半角数値でないと保存できないこと' do
          @order_address.phone_number = 'abc'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('電話番号は、10または11桁でないといけません。')
      end

      it '電話番号が10桁以上11桁以内の半角数値でないと保存できないこと' do
          @order_address.phone_number = 123-4567
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('電話番号は、10または11桁でないといけません。')
      end

      it '商品が紐付いていないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end

      it 'ユーザーが紐付いていないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'トークンが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("トークンを入力してください")
      end
    end
  end
end
