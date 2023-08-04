class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :town, :block_number, :building_name, :phone_number
  with_options presence: true do
    validates :post_code
    validates :town
    validates :block_number
    validates :phone_number
    validates :user_id
    validates :item_id

  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  def save
    
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, town: town, block_number: block_number, building_name: building_name, phone_number:phone_number, order_id: order.id)
    
  end

end