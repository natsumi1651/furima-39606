class Item < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true, unless: :was_attached?
  
  belongs_to :user
end
