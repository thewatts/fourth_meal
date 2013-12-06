class Item < ActiveRecord::Base
  # attr_accessor :photo_file_name
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, presence: true
  validates :description, presence: true
  validate :retired, presence: true
  validates_numericality_of :price, :greater_than_or_equal_to => 0

  belongs_to :restaurant

  has_many :item_categories
  has_many :categories, :through => :item_categories

  has_many :order_items
  has_many :orders, :through => :order_items

  has_many :line_items

  has_attached_file :photo,
    :default_url => "/images/:style/missing.png"

  def self.filter_by_category(category)
    joins(:categories).where("categories.title"=> category)
  end

  def self.active
    where(:retired => false)
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      true
    else
      errors[:base] << "Line Items present"
      false
    end
  end

end
