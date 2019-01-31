Rails.application.routes.draw do
  root 'messages#index'
  resources :messages, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
