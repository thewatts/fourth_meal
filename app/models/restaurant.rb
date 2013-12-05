class Restaurant < ActiveRecord::Base
  has_many :categories
  has_many :items

  validates :name, presence: true
  validates :description, presence: true
end
