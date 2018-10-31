class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      return render 'users/create_succeeded'
    end
    render 'users/create_failed'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
