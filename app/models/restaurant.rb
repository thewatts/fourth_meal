class Restaurant < ActiveRecord::Base
  has_many :categories
  has_many :items
  has_many :orders
  has_many :restaurant_users

  validates :name, presence: true
  validates :description, presence: true

  def to_param
    name.downcase.gsub(" ", "_")
    name.downcase.gsub(/\W/, "")
  end

  def self.find_by_slug(target)
    all.detect{|c| c.to_param == target}
  end

  def find_owner
    self.restaurant_users.where(role: "owner").last.user 
  end

end
