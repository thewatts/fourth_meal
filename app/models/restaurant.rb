class Restaurant < ActiveRecord::Base
  has_many :categories
  has_many :items
  has_many :orders
  has_many :restaurant_users

  validates :name, presence: true
  validates :description, presence: true
  validates_inclusion_of :status, :in => ["pending", "rejected", "approved"]

  def to_param
    name.downcase.gsub(" ", "_")
    name.downcase.gsub(/\W/, "")
  end

  def self.find_by_slug(target)
    all.detect{|c| c.to_param == target}
  end

  def find_owner
    owners.last
  end

  def owners
    self.restaurant_users.where(role: "owner").collect do |ru|
      ru.user
    end
  end

  def employees
    self.restaurant_users.where(role: "employee").collect do |ru|
      ru.user
    end
  end

  def is_owner?(user)
    owners.include?(user)
  end

  def is_employee?(user)
    employees.include?(user)
  end

  def active?
    self.active
  end

  def activate
    self.update(active: true)
  end

  def deactivate
    self.update(active: false)
  end

  def toggle_status
    self.active? ? deactivate : activate
  end

  def <=> (other)
    self.id <=> other.id
  end

end
