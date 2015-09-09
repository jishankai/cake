class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :thumb
      t.float :price
      t.text :taste
      t.text :crafts
      t.text :efficacy
      t.text :tips
      t.integer :inventory

      t.timestamps null: false
    end
  end
end
