class CaregiversController < ApplicationController
  before_action :require_login

  def index
    @caregivers = current_user.caregivers
  end

  def new
    @caregiver = Caregiver.new
  end

  def create
    redirect_to root_path
  end

  private

  def require_login
    if ! logged_in?
      redirect_to login_path
    end
  end

end
