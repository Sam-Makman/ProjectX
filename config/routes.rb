Rails.application.routes.draw do

  get 'sessions/new'

root "users#new"
post 'api/lookup'
post 'api/service'
get 'users/new'
post 'users', to: "users#create"
get 'users/edit/:id', to: 'users#edit', as: 'user'
post 'api/regcode'

get    'login'   => 'sessions#new'
post   'login'   => 'sessions#create'
delete 'logout'  => 'sessions#destroy'

patch 'users/edit/:id' => 'users#update'

resources :caregivers
resources :users
resources :account_activations, only: [:edit]
resources :password_resets,     only: [:new, :create, :edit, :update]

end
