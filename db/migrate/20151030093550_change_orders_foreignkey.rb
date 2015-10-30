class ChangeOrdersForeignkey < ActiveRecord::Migration
  def change
    rename_column :orders, :wechat_id, :customer_id
  end
end
