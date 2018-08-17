class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.text :presigned_url
      t.text :final_url
      t.datetime :uploaded_at
      t.references :membership, foreign_key: true

      t.timestamps
    end
  end
end
