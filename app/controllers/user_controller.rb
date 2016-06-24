class UserController < ApplicationController

def new
  @user = User.new
end

def create

#   if params[:unique_id].nil?
#     flash[:error] = "please enter a unique id"
#     redirect_to root_path
#
# else
  @device = UnregisteredDevice.find_by(unique_id: params[:unique_id].downcase)
  if @device && @device[:active]
    flash[:error] = "This Device already has been registered"
    redirect_to root_path
  else
    @unreg = UnregisteredDevice.find_by(unique_id: params[:unique_id].downcase)
    if @unreg
      @user =  User.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name],
      home_phone: params[:home_phone], cell_phone: params[:cell_phone], device_id: @unreg[:device_id])
      if @user.save
          @unreg.update_column(:active, true)
        render 'success'
      else
        if User.find_by( email: params[:email] )
          flash[:error] = "Email Already Registered"
        else
        flash[:error] = "Invalid Email"
        end
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid Registration Code"
      redirect_to root_path
    end
  end
# end
end

private

  def reg_params
    params.permit(:email, :first_name, :last_name, :home_phone, :cell_phone, :unique_id)
  end
end
