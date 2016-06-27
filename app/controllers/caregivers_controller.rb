class CaregiversController < ApplicationController

  def new
    @caregiver = Caregiver.new
  end

  def create
  redirect_to root_path
  end
  
end
