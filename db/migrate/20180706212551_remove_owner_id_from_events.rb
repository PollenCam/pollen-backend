class RemoveOwnerIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :owner_id, :integer
  end
end
