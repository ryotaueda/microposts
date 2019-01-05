class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  # ログイン認証
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)  # Micropostの数のカウントをViewで表示するときのため。
    @count_microposts = user.microposts.count
  end
  
end
