Rails.application.routes.draw do

  get 'sessions/new'

root "users#new"
get 'api/lookup'
get 'api/service'
get 'api/unregistered'
get 'users/new'
post'users', to: "users#create"
get 'api/regcode'

get    'login'   => 'sessions#new'
post   'login'   => 'sessions#create'
delete 'logout'  => 'sessions#destroy'

get 'caregivers', to: 'caregivers#new'
post 'caregivers', to: 'caregivers#create'

end
