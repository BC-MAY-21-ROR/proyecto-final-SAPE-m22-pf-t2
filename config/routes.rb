Rails.application.routes.draw do
  resources :users
  devise_for :admin, controllers: { omniauth_callbacks: 'omniauth' }

  get 'landing_page/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'dashboard/index'
  get 'dashboard/balance_sheet'
  get 'dashboard/business_date'
  get 'dashboard/inventory'
  get 'dashboard/providers'
  get 'dashboard/sales_and_purcharses'
  get 'dashboard/statement_of_income'
  # Defines the root path route ("/")
  root 'landing_page#index'
end
