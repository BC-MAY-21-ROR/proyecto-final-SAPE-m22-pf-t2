Rails.application.routes.draw do
  resources :providers, except: [:show]
  resources :clients, except: [:show]
  resources :expenses, except: [:show]
  resources :sales, :resupplies
  resources :products, path: '/inventory/products'
  resources :users, only: %i[show edit update]

  resource :business, :inventory, :financial_state

  devise_for :user, controllers: {
    omniauth_callbacks: 'omniauth',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

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

  # Clients PDF Report
  get '/clients_pdf', to: 'clients#clients_pdf', as: 'clients_pdf'

  # Providers PDF Report
  get '/providers_pdf', to: 'providers#providers_pdf', as: 'providers_pdf'

  # Sales
  get '/search_products', to: 'sales#search_products'
  post '/add_product_to_sale', to: 'sales#add_product_to_sale'
  delete '/remove_product_to_sale', to: 'sales#remove_product_from_sale'
  get '/sales/:id/sale_details_pdf', to: 'sales#sale_details_pdf', as: 'sale_details_pdf'
  get 'monthly_sales_pdf', to: 'sales#monthly_sales_pdf'

  # Monthly resupplies PDF
  get 'monthly_resupplies_pdf', to: 'resupplies#monthly_resupplies_pdf'

  # Financial Statement
  get 'financial_state_of_month', to: 'financial_states#financial_state_of_month'
  get 'financial_state_pdf', to: 'financial_states#financial_state_pdf'

  # Dashboard & landing
  get 'dashboard', to: 'dashboard#index'
  root 'landing#index'
end
