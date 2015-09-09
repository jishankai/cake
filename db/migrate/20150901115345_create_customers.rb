class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :wechat_id
      t.string :name
      t.string :mobile
      t.string :home_address
      t.string :school_address
      t.string :company_address

      t.timestamps null: false
    end
  end
end
