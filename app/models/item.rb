class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipmentfee
  belongs_to :prefecture
  belongs_to :waitingday

  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1, message: "は空欄にはできません。" }
  validates :status_id, numericality: { other_than: 1, message: "は空欄にはできません。" }
  validates :shipmentfee_id, numericality: { other_than: 1, message: "は空欄にはできません。" }
  validates :prefecture_id, numericality: { other_than: 1, message: "は空欄にはできません。" }
  validates :waitingday_id, numericality: { other_than: 1, message: "は空欄にはできません。" }
  validates :item_price, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }

  validates :image, presence: true

  belongs_to :user
  has_one :order
end
