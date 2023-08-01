class AddItemPriceToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :item_price, :integer
  end
end
