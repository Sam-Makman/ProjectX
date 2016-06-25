Rails.application.routes.draw do

root "users#new"

get 'api/lookup'
get 'api/service'
get 'api/unregistered'
get 'users/new'
post'users', to: "users#create"
get 'api/regcode'

end
