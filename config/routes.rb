Rails.application.routes.draw do

  get 'sessions/new'

root "users#new"

get 'api/lookup'
get 'api/service'
get 'api/unregistered'
get 'users/new'
post'users', to: "users#create"
get 'api/regcode'

get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

get 'caregivers', to: 'caregivers#new'
post 'caregivers', to: 'caregivers#create'

end
