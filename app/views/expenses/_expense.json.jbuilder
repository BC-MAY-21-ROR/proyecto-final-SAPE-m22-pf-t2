json.extract! expense, :id, :rent, :salaries, :general_charges, :service_bills, :commissions, :taxes, :business_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
