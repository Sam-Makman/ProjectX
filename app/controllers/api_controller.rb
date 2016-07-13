class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

 # get
 # /api/lookup
 # params device_id
 #I believe this is depriciated. Should be removed.
  def lookup
    @user = User.find_by( device_id: params[:device_id])
    if @user
        render :json => {sucess: 'true' , message:'user exists'}
    else
       regcode
    end
  end

  # get
  # /api/unregistered
  # params device_id
  # returns unique_id
  def unregistered
    @unregistered = UnregisteredDevice.create(device_id: params[:device_id] , unique_id: generate_code(10))
    if @unregistered
      render :json => { sucess: 'true',
        message: "Device is not Registered",
        data:{
          registration_id: @unregistered[:unique_id]
              }
          }
    else
       render :json => {sucess: "false", error: "server error"}
    end
  end

 # get
 # api/regcode
 #params device_id
 # returns unique_id

 def regcode
   @unreg = UnregisteredDevice.find_by(device_id: params[:device_id])
   if @unreg
     render :json => { sucess: 'true',
       message: "Device is not Registered",
       data:{registration_id: @unreg[:unique_id],
                      registered: @unreg[:active]
            }
          }
   else
     unregistered
   end

 end


  # get
  # api/service
  # params device_id , requested_service
  # returns success
  # fix this
  def service
    @user = User.find_by( device_id: params[:device_id])
    if @user
      @request = RequestedAction.create(device_id: params[:device_id], requested_service: "Help")
      if @user.caregivers.size == 0
            render :json => {sucess: 'false' ,
                              message: 'no careivers registered'}
      elsif @request
          render :json => {sucess: 'true' ,
                            message: 'request processed'}
      else
          render :json => {sucess: 'false' ,
                            error: 'request failed'}
      end
    else
      regcode
    end
  end

  private

  def request_params
    params.require(:request).permit(:device_id , :requested_service)
  end

  def generate_code(number)
    charset =  Array('a'..'z')
    Array.new(number) { charset.sample }.join
  end

end
