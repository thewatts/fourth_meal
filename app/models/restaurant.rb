class Restaurant < ActiveRecord::Base
  has_many :categories
  has_many :items

  validates :name, presence: true
  validates :description, presence: true

  def to_param
    name.downcase.gsub(" ", "_")
    name.downcase.gsub(/\W/, "")
  end
end
