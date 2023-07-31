class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.text :description, null: false
      t.integer :category_id, null: false
      t.integer :status_id, null: false
      t.integer :shipmentfee_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :waitingday_id, null: false
      t.integer :item_price, null: false
      t.timestamps, null: false
   
    end
  end
end
