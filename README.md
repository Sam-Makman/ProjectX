#API

######get api/lookup 
#####param device_id
checks to see if the device id has been registered with our service if not it routs to api/unregistered and creates a new registration token

######get api/unregisted
######params device_id 
returns a registration token (unique_id) this token is used on our website to match a device with an account

#####get api/service
#####params device_id , requested_service
registers a requested service to a device. returns the success of the operation.
