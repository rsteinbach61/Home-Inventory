class User < ActiveRecord::Base

  has_many :items
  has_many :rooms, through: :houses
  has_many :houses, through: :items
  has_secure_password


  def slug
    new_name = username.downcase
    new_name.gsub(' ', '-')
  end

  def self.find_by_slug(name_slug)
    User.all.find{|a| a.slug == name_slug}
  end
end
