class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :town, :block_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :post_code
    validates :town
    validates :block_number
    validates :phone_number
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "は空欄にはできません。" }
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は、3または4桁でないといけません' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は、10または11桁でないといけません。' }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code:, prefecture_id:, town:, block_number:,
                   building_name:, phone_number:, order_id: order.id)
  end
end
