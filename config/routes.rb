Rails.application.routes.draw do

root "user#new"

get 'api/lookup'
post 'api/service'
get 'api/unregistered'
get 'user/new'
post'user/create'

end
