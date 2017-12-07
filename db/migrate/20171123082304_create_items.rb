class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :name
      t.integer :room_id
    end
  end
end
