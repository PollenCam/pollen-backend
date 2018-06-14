class AddFullNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :text
  end
end
