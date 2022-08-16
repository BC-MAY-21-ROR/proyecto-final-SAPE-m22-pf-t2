Rails.application.routes.draw do
  resources :providers, except: [:show]
  resources :clients, except: [:show]
  resources :expenses, except: [:show]
  resources :sales, :resupplies
  resources :products, path: '/inventory/products'
  resources :users, only: %i[show edit update]
  resources :financial_state

  resource :business, :inventory

  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  # Business
  get '/business/employees',
      to: 'businesses#index_employees', as: 'employees'

  get '/business/employees/new',
      to: 'businesses#new_employee', as: 'new_employee'

  post '/switch_to_own_business',
       to: 'businesses#switch_to_own_business'

  # Business enrollment
  post '/create_and_enroll_employee',
       to: 'business_enrollments#create_and_enroll_employee'

  post '/enroll_existing_user_to_current_business',
       to: 'business_enrollments#enroll_existing_user_to_current_business'

  post '/join_to_enrolled_business',
       to: 'business_enrollments#join_to_enrolled_business'

  delete '/remove_employee_from_current_business',
         to: 'business_enrollments#remove_employee_from_current_business'

  # Sales
  get '/search_products', to: 'sales#search_products'
  post '/add_product_to_sale', to: 'sales#add_product_to_sale'
  delete '/remove_product_to_sale', to: 'sales#remove_product_from_sale'
  get '/sales/:id/details_pdf', to: 'sales#sale_details_pdf', as: 'sale_details_pdf'

  # Financial Statement
  get 'financial_state/index'
  get 'products/new_resupply', to: 'products#new'

  # Dashboard & landing
  get 'dashboard', to: 'dashboard#index'
  root 'landing#index'
end
