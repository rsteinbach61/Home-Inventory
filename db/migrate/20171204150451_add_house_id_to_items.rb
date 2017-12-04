class AddHouseIdToItems < ActiveRecord::Migration
  def up
    add_column :items, :house_id, :string
  end

  def down
    remove_column :items, :house_id, :string
  end
end
