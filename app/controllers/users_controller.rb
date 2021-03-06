class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]


def index
  redirect_to root_path
end

def new
  if logged_in?
    redirect_to caregivers_path
  else
    @user = User.new
  end
end

def create
  @device = UnregisteredDevice.find_by(unique_id: params[:unique_id].downcase)
  @user = User.new(reg_params)
  if @device
    if@device[:active]
      flash[:error] = "This Device already has been registered"
      redirect_to root_path
    else

      @user[:device_id] = @device[:device_id]
      if @user.save
          @device.delete
          log_in(@user)
          UserMailer.account_activation(@user).deliver_now
          flash[:info] = "Please check your email to activate your account!"
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(reg_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

private

  def reg_params
    params.require(:user).permit(:email, :title, :first_name, :last_name, :home_phone, :cell_phone,
                      :password, :password_confirmation )
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

end
