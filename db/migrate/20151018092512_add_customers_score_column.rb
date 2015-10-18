class AddCustomersScoreColumn < ActiveRecord::Migration
  def change
    add_column :customers, :score, :integer, :null => false, :defaults => 0, after: :mobile
  end
end
