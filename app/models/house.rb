class House < ActiveRecord::Base
  has_many :rooms
  has_many :items, through: :rooms
  belongs_to :user


end
