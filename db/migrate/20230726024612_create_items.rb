class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.name :string, null: false
      t.description :text, null: false
      t.category_id :integer, null: false
      t.status_id :integer, null: false
      t.shipmentfee_id :integer, null: false
      t.prefecture_id :integer, null: false
      t.waitingday_id :integer, null: false
      t.item_price :integer, null: false
      t.timestamps, null: false
   
    end
  end
end
