class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def lookup
    @user = User.find_by( device_id: params[:device_id])
    if @user
        render :json => {user: 'exists' , code: 1}
    else
       render :json => {user: 'Does Not Exist' , code: 0}
    end
  end

  def unregistered
    @unregistered = UnregisteredDevice.new
    @unregistered.device_id = params[:device_id]

  def service
    @request = RequestedAction.create(request_params)
    if @request
          render :json => {sucess: 'true' , code: 1}
    else
          render :json => {sucess: 'false' , code: 0}
    end
  end

  private

  def request_params
    params.require(:request).permit(:device_id , :requested_service)
  end
end
