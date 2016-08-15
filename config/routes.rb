Rails.application.routes.draw do

  get 'sessions/new'

root "users#new"
get 'api/lookup'
get 'api/service'
get 'users/new'
post 'users', to: "users#create"
get 'users/edit/:id', to: 'users#edit', as: 'user'
get 'api/regcode'

get    'login'   => 'sessions#new'
post   'login'   => 'sessions#create'
delete 'logout'  => 'sessions#destroy'

patch 'users/edit/:id' => 'users#update'

resources :caregivers
resources :users
resources :account_activations, only: [:edit]
resources :password_resets,     only: [:new, :create, :edit, :update]

end
