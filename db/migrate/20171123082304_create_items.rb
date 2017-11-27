class CreateItems < ActiveRecord::Migration[4.2.5]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :name
      t.integer :room_id
    end
  end
end
