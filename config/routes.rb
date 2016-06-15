Rails.application.routes.draw do

root "user#new"

get 'api/lookup'
get 'api/service'
get 'api/unregistered'
get 'user/new'
post'user/create'
get 'api/regcode'

end
