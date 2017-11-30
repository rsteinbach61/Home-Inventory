class AddValueToItems < ActiveRecord::Migration
    def up
      add_column :items, :value, :float
    end

    def down
      remove_column :items, :value, :float
    end
end
