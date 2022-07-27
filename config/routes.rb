Rails.application.routes.draw do
  resources :expenses
  resources :products
  resource :business
  resources :users, only: %i[show edit update]
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  # Business
  get '/business/employees',
      to: 'businesses#index_employees', as: 'employees'

  get '/business/employees/new',
      to: 'businesses#new_employee', as: 'new_employee'

  # Business
  post 'switch_to_own_business',
       to: 'businesses#switch_to_own_business'

  # Business enrollment
  post 'create_and_enroll_employee',
       to: 'business_enrollments#create_and_enroll_employee'

  post 'enroll_existing_user_to_current_business',
       to: 'business_enrollments#enroll_existing_user_to_current_business'

  post 'join_to_enrolled_business',
       to: 'business_enrollments#join_to_enrolled_business'

  delete 'remove_employee_from_current_business',
         to: 'business_enrollments#remove_employee_from_current_business'

  # Dashboard & landing
  get 'dashboard', to: 'dashboard#index'
  root 'landing#index'
end
