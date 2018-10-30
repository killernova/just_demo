class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless current_user
      return redirect_to login_path
    end
  end
end
