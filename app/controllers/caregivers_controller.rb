class CaregiversController < ApplicationController
  before_action :require_login

  def index
    @caregivers = current_user.caregivers.all
  end

  def new
    @caregiver = Caregiver.new
  end

  def create
    @caregiver = current_user.caregivers.build(caregiver_params)
    if @caregiver.save
      redirect_to caregivers_path
    else
      render 'new'
    end
  end

  def show
    redirect_to caregivers_path
  end

  def edit
    redirect_to caregivers_path
  end

  def update
    redirect_to caregivers_path
  end

  def delete
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

end
