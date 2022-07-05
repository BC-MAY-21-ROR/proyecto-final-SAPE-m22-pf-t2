Rails.application.routes.draw do
  devise_for :admin, controllers: { omniauth_callbacks: 'omniauth' }

  get 'landing_page/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'landing_page#index'
end
