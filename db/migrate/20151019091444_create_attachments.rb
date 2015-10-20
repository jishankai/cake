class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
