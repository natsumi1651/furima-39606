require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入内容の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'userとitemが紐付いていて、post_code、prefecture_id、town、block_number、phone_number、tokenがあれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end

      it 'post_codeが「3桁ハイフン4桁」の形式なら保存できること' do
        valid_post_codes = ['123-4567', '456-7890', '001-0010']
        valid_post_codes.each do |post_code|
          @order_address.post_code = post_code
          expect(@order_address).to be_valid
        end
      end

      it 'phone_numberが10桁以上11桁以内の半角数値なら保存できること' do
        valid_phone_numbers = ['1234567890', '09876543210', '12345678901']
        valid_phone_numbers.each do |phone_number|
          @order_address.phone_number = phone_number
          expect(@order_address).to be_valid
        end
      end

    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが「3桁ハイフン4桁」の形式でないと保存できないこと' do
        invalid_post_codes = ['1234567', '12-34567', '123-45678', 'aaa-bbbb']
        invalid_post_codes.each do |post_code|
          @order_address.post_code = post_code
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Post code should be in the format 3 digits - 4 digits")
        end
      end
     
      it 'prefecture_idがid: 1だと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'townが空だと保存できないこと' do
        @order_address.town = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Town can't be blank")
      end

      it 'block_numberが空だと保存できないこと' do
        @order_address.block_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block number can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁以上11桁以内の半角数値でないと保存できないこと' do
        invalid_phone_numbers = ['123456789', '123456789012', 'abc', '123-4567']
        invalid_phone_numbers.each do |phone_number|
          @order_address.phone_number = phone_number
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number should be 10 to 11 digits")
        end
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
