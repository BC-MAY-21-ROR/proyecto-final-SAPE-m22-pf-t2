Rails.application.routes.draw do
  resources :businesses
  resources :users, path: '/dashboard/employees'
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  get 'dashboard', to: 'dashboard#index'
  get 'dashboard/employees'

  post 'dashboard/enroll_existing_user_to_current_business',
       to: 'users#enroll_existing_user_to_current_business',
       as: 'enroll_existing_user_to_current_business'

  get 'dashboard/balance_sheet'
  get 'dashboard/inventory'
  get 'dashboard/sales_and_purcharses'
  get 'dashboard/statement_of_income'

  # Defines the root path route ("/")
  root 'landing#index'
end
