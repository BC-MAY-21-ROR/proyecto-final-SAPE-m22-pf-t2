Rails.application.routes.draw do
  resource :business
  resources :users, only: %i[show edit create update]
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  # Business
  get '/business/employees',
      to: 'businesses#index_employees', as: 'employees'

  get '/business/employees/new',
      to: 'businesses#new_business_employee', as: 'new_employee'

  post 'enroll_existing_user_to_current_business',
       to: 'users#enroll_existing_user_to_current_business'

  post 'join_to_enrolled_business',
       to: 'businesses#join_to_enrolled_business'

  post 'switch_to_own_business',
       to: 'businesses#switch_to_own_business'

  get 'dashboard', to: 'dashboard#index'

  root 'landing#index'
end
