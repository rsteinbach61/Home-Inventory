class AddPurchaseDateToItems < ActiveRecord::Migration
  def up
    add_column :items, :purchase_date, :date
  end

  def down
    remove_column :items, :purchase_date, :date
  end
end
