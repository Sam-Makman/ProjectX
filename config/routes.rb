Rails.application.routes.draw do

  get 'sessions/new'

root "users#new"
get 'api/lookup'
get 'api/service'
get 'api/unregistered'
get 'users/new'
post 'users', to: "users#create"
get 'users/edit/:id', to: 'users#edit', as: 'user'
get 'api/regcode'

get    'login'   => 'sessions#new'
post   'login'   => 'sessions#create'
delete 'logout'  => 'sessions#destroy'


resources :caregivers
end
