class User < ActiveRecord::Base

  has_many :items
  has_many :rooms, through: :houses
  has_many :houses
  has_secure_password

end
