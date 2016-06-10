require "#{Rails.root}/app/view_models/registration.rb"
class UserController < ApplicationController

def new
  @user = User.new
end


def create
  @unreg = UnregisteredDevice.find_by(unique_id: params[:unique_id])
  if @unreg
    @unreg.update_column(:active, true)
    @user =  User.new(email: params[:email], device_id: @unreg[:device_id])
    if @user.save
      render 'success'
    else
      if User.find_by( email: params[:email] )
        flash[:error] = "Email Already Registered"
      else
      flash[:error] = "Invalid Email"
      end
      render 'new'
    end
  else
    flash[:error] = "Invalid Registration Code"
    render 'new'
  end
end

private

  def reg_params
    params.permit(:email, :unique_id)
  end
end
