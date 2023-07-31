class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre

  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipmentfee_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :waitingday_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_price, presence: true
  validates :image, presence: true


  belongs_to :user
end

#validates :name, presence: true, unless: :was_attached?
#unless: :was_attached?はいるか？
#validates :genre_id, numericality: { other_than: 1 , message: "can't be blank"}