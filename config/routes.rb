Rails.application.routes.draw do
  resource :business
  resources :users, path: '/business/employees'
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  get 'dashboard', to: 'dashboard#index'

  post 'enroll_existing_user_to_current_business',
       to: 'users#enroll_existing_user_to_current_business'

  post 'switch_to_own_business',
       to: 'businesses#switch_to_own_business'

  post 'join_to_enrolled_business',
       to: 'businesses#join_to_enrolled_business'

  delete 'remove_employee_from_current_business',
         to: 'businesses#remove_employee_from_current_business'

  root 'landing#index'
end
