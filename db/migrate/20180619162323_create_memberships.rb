class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :role, index: true, default: 0

      t.timestamps
    end

    add_index :memberships, [:user_id, :event_id]
  end
end
