Rails.application.routes.draw do
  resources :businesses
  devise_for :admin, controllers: { omniauth_callbacks: 'omniauth', registrations: 'admins/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'dashboard', to: 'dashboard#index'

  get 'dashboard/balance_sheet'
  get 'dashboard/business_date'
  get 'dashboard/inventory'
  get 'dashboard/providers'
  get 'dashboard/sales_and_purcharses'
  get 'dashboard/statement_of_income'

  # Defines the root path route ("/")
  root 'landing_page#index'
end
