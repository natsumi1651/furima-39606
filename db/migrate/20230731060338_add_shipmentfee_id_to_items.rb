class AddShipmentfeeIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :shipmentfee_id, :integer
  end
end
