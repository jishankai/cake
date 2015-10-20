class AddOrdersColumn < ActiveRecord::Migration
  def change
    add_column :orders, :pre_pay_id_expired_at, :datetime, after: :wechat_id
    add_column :orders, :prepay_id, :string, after: :wechat_id
    add_column :orders, :pay_serial_number, :string, after: :wechat_id
    add_column :orders, :is_cancel, :boolean, after: :is_paid
    add_column :orders, :pay_logs, :text, after: :is_paid, array:true
  end
end
