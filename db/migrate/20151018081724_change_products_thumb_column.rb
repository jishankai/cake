class ChangeProductsThumbColumn < ActiveRecord::Migration
  def change
    change_column :products, :thumb, :text, array:true
  end
end
