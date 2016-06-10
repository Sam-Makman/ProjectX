Rails.application.routes.draw do

# root "api#request"

get 'api/lookup'
post 'api/service'
get 'api/unregistered'

end
