class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name_and_description, against: %i[name description]

  belongs_to :business
  has_many :product_sales
  has_many :sales, through: :product_sales
  has_many :purchases
  has_many :spents, through: :purchases

  validates :name, :code, :price, :stock, :description, presence: true

  validates :name, length: { minimum: 4 }
  validates :code, length: { minimum: 2 }
  validates :description, length: { minimum: 5 }

  def self.search(query, business_id)
    Product.search_by_name_and_description(query)
           .select { |product| product.business_id == business_id }
  end
end
