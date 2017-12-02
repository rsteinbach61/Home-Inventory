class AddPicFileNameToItems < ActiveRecord::Migration
  def up
    add_column :items, :pic_file_name, :string
  end

  def down
    remove_column :items, :pic_file_name, :string
  end
end
