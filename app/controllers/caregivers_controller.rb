class CaregiversController < ApplicationController
  before_action :require_login
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @caregivers = current_user.caregivers.all
  end

  def new
    @caregiver = Caregiver.new
  end

  def create
    if current_user.caregivers.length >= 4
      flash[:error] = "You can only register up to 4 caregivers"
      redirect_to caregivers_path
    else
      @caregiver = current_user.caregivers.build(caregiver_params)
      if @caregiver.save
        redirect_to caregivers_path
      else
        render 'new'
      end
    end
  end

  def show
    redirect_to caregivers_path
  end

  def edit
    @caregiver = Caregiver.find(params[:id])
  end

  def update
    @caregiver = Caregiver.find(params[:id])
    if @caregiver.update(caregiver_params)
      redirect_to caregivers_path
    else
      render :edit
    end
  end

  def destroy
      @caregiver = Caregiver.find(params[:id])
      @caregiver.destroy
      redirect_to caregivers_path
  end

  private

  def require_login
    if ! logged_in?
      redirect_to login_path
    end
  end

  def caregiver_params
      params.require(:caregiver).permit(:first_name, :last_name, :phone_number)
  end

  def correct_user
    @caregiver = current_user.caregivers.find_by(id: params[:id])
    redirect_to root_url if @caregiver.nil?
  end

end
