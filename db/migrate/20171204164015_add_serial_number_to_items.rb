class AddSerialNumberToItems < ActiveRecord::Migration
  def up
    add_column :items, :serial_number, :string
  end

  def down
    remove_column :items, :serial_number, :string
  end
end
