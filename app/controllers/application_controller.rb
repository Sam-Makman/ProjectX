class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  def default_url_options
    if Rails.env.production?
      { :host => "localhost:3000"}
    else
      {:host => "https://evening-plains-33058.herokuapp.com"}
    end
  end
end
