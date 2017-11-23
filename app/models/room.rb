class Room < ActiveRecord::Base
has_many :items
belongs_to :house
end
