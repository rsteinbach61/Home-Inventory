class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.integer :user_id
      t.string :name
      t.integer :room_id
    end
  end
end
