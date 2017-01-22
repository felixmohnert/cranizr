Rails.application.routes.draw do
  resources :r_packages, only: [:index, :show]

  root 'home#index'
end
