class AddUserIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :user_id, :references, null: false, foreign_key: true
  end
end
