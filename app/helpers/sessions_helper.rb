module SessionsHelper
  def current_user
    # 現在ログインしているユーザを取得する
    @current_user ||= User.find_by(id: session[:user_id])
    # @curent_userにすでに現在のログインユーザが代入されていたら何もせず、代入されていなかったらUser.find(...)からログインユーザを取得し。@current_userに代入する
  end
  
  def logged_in?
    # ユーザがログインしていればtrueを返し、ログインしていなければfalseを返す。
    !!current_user
    
  end
end
