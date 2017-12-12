class RemoveHouseIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :house_id
  end
end
