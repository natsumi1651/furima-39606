class AddWaitingdayIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :waitingday_id, :integer
  end
end
