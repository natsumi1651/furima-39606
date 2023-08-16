require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の保存' do
    context '商品が投稿できる場合' do
      it 'ユーザーが紐付いていて、商品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数、販売価格が全て入っていれば商品を投稿できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が投稿できない場合' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーが空では登録できない' do
        @item.category = Category.find_by(id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは空欄にはできません。")
      end

      it '商品の状態が空では登録できない' do
        @item.status = Status.find_by(id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は空欄にはできません。")
      end

      it '配送料の負担が空では登録できない' do
        @item.shipmentfee = Shipmentfee.find_by(id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は空欄にはできません。")
      end

      it '発送元の地域が空では登録できない' do
        @item.prefecture = Prefecture.find_by(id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("都道府県は空欄にはできません。")
      end

      it '発送までの日数が空では登録できない' do
        @item.waitingday = Waitingday.find_by(id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は空欄にはできません。")
      end

      it '販売価格が空では登録できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は数値で入力してください")
      end

      it '販売価格が300円以上でないと登録できない' do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end

      it '販売価格が9999999円以下でないと登録できない' do
        @item.item_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end

      it '販売価格が半角数値でないと登録できない' do
        @item.item_price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it '販売価格が半角数値でないと登録できない' do
        @item.item_price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
