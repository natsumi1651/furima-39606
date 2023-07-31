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
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipmentfee_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :waitingday_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_price, presence: true, numericality: {
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9999999,
    only_integer: true,
  }
  validates :item_price, format: { with: /\A[0-9]+\z/ }
  validates :image, presence: true

  belongs_to :user
end
