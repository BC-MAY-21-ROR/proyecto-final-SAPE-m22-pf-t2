json.extract! inventory, :id, :product_description, :stock, :incomes, :outcomes, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
