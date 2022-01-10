Rails.application.routes.draw do
  get 'gateway/create'
  post 'gateway/create'
  resources :transactions
  resources :bank_accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
