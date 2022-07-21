json.extract! product, :id, :name, :code, :price, :description, :business_id, :created_at, :updated_at
json.url product_url(product, format: :json)
