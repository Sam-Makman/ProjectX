class UsersController < ApplicationController

def index
end

def new
  @user = User.new
end

def create
  @device = UnregisteredDevice.find_by(unique_id: params[:unique_id].downcase)
  if @device
    if@device[:active]
      flash[:error] = "This Device already has been registered"
      render 'new'
    else
      @user = User.new(reg_params)
      @user[:device_id] = @device[:device_id]
      if @user.save
          @device.update_column(:active, true)
          redirect_to caregivers_path
      else
        render 'new'
      end
    end
  else
    flash[:error] = "Invalid Registration Code"
    render 'new'
  end
end

private

  def reg_params
    params.require(:user).permit(:email, :first_name, :last_name, :home_phone, :cell_phone,
                      :password, :password_confirmation )
  end
end
