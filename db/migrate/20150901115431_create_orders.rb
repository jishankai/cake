class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :wechat_id
      t.text :context
      t.float :fee
      t.text :remark
      t.boolean :is_paid
      t.boolean :is_deliveried

      t.timestamps null: false
    end
  end
end
