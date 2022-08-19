class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name_and_description, against: %i[name description]

  belongs_to :business
  has_many :product_sales
  has_many :sales, through: :product_sales
  has_many :resupplies

  validates :name, :code, :purcharse_price, :sale_price, :stock, presence: true

  validates :code, length: { minimum: 2 }
  validates :name, length: { minimum: 4 }

  def self.search(query, business_id)
    search_by_name_and_description(query)
      .select { |product| product.business_id == business_id && product.has_stock? }
  end

  def self.calculate_total_value(business)
    business.products.inject(0) { |sum, product| sum + product.calculate_value }
  end

  def calculate_total_price(quantity)
    sale_price * quantity.to_i
  end

  def calculate_value
    sale_price * stock
  end

  def enough_stock?(quantity)
    stock >= quantity
  end

  def has_stock?
    stock > 0
  end
end
