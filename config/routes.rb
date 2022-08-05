Rails.application.routes.draw do

  resources :sales
  resources :products, path: '/inventory/products'
  resources :expenses
  resources :users, only: %i[show edit update]
  resource :inventory
  resources :register
  resources :financial_statement
  resource :business
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  # Business
  get '/business/employees',
      to: 'businesses#index_employees', as: 'employees'

  get '/business/employees/new',
      to: 'businesses#new_employee', as: 'new_employee'

  # Business
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
  post '/add_product_to_sale', to: 'sales#add_product_to_sale'
  get '/sales/:id/details_pdf', to: 'sales#sale_details_pdf', as: 'sale_details_pdf'

  # Register
  get 'register/index'

  # Financial Statement
  get 'financial_statement/index'
  
  # Dashboard & landing
  get 'dashboard', to: 'dashboard#index'
  root 'landing#index'
end
