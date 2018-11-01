class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    return render 'create_failed' if @user.nil?
    if verify_password(@user)
      log_in @user
      remember(@user) if session_params[:remember_me] == '1'
      return render 'create_succeeded'
    end
    render 'create_failed'
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :password_confirmation, :remember_me)
  end


  def verify_password(user)
    if user.authenticate(session_params[:password])
      true
    else
      Rails.logger.info("Invalid Password: #{session_params[:password]}")
      user.errors.add(:password, '请输入正确的密码')
      false
    end
  end
end

