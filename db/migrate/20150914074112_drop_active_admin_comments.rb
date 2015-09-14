class DropActiveAdminComments < ActiveRecord::Migration
  def change
    drop_table :active_admin_comments
    drop_table :active_users
  end
end
