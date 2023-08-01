class AddStatusIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :status_id, :integer
  end
end
