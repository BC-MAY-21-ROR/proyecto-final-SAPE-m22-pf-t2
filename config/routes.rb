Rails.application.routes.draw do
  resource :business
  resources :users, path: '/dashboard/employees'
  devise_for :user, controllers: { omniauth_callbacks: 'omniauth', registrations: 'users/registrations' }

  get 'dashboard', to: 'dashboard#index'
  get 'dashboard/employees'

  post 'enroll_existing_user_to_current_business',
       to: 'users#enroll_existing_user_to_current_business'

  post 'join_to_enrolled_business',
       to: 'businesses#join_to_enrolled_business'

  root 'landing#index'
end
