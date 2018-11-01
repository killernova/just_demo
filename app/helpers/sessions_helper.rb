module SessionsHelper
  def log_in user
    session[:user_id] = user.id
    cookies.signed_or_encrypted[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user = User.find_by(id: cookies.signed_or_encrypted[:user_id])
      if user.authenticate?(cookies.signed_or_encrypted[:remember_token])
        @current_user ||= user
      end
    end
  end

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
