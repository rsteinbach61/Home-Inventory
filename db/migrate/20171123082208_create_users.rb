class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :CreateUsers do |t|
      t.string :name
    end
  end
end
