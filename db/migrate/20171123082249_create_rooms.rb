class CreateRooms < ActiveRecord::Migration[4.2.5]
  def change
    create_table :rooms do |t|
      t.integer :house_id
      t.string :name
    end
  end
end
