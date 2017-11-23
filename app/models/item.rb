class Item < ActiveRecord::Base
belongs_to :user
belongs_to :house
belongs_to :room
end
