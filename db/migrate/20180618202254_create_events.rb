class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :owner, index: true, foreign_key: { to_table: :users }
      t.text :locator, index: true

      t.timestamps
    end
  end
end
