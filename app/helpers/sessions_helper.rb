module SessionsHelper
  def logged_in?
    current_user.present?
  end

  def logout
    forget current_user
    @current_user = nil
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
