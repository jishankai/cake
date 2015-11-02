class AddOrdersDeliveryTimeColumn < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_time, :string, after: :fee
  end
end
