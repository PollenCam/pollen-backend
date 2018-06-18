class ChangeLocatorIndexOnEvents < ActiveRecord::Migration[5.2]
  def change
    remove_index :events, [:locator]
    add_index :events, [:locator], unique: true
  end
end
