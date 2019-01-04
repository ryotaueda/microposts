# ログイン機能

class SessionsController < ApplicationController
  def new
  end

  def create
    # ログインアクション
    
    email = params[:session][:email].downcase
    # フォームデータのemailを小文字化して取得
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
      # @userのusers#showへとリダイレクト
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
      # sessions/new.html.erbを再表示
    end
  end

  def destroy
    # ログアウトアクション
    
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
    # ログアウト後はトップページにリダイレクト
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    # 入力フォームのemailと同じメールアドレスを持つユーザーを検索し@userへ代入する。
    
    if @user && @user.authenticate(password)
      # @userが存在するか確認 かつ @userのパスワードがあっているか確認
      # email,passwordの組み合わせが間違っていた場合には、ログインできないs
      
      # ログイン成功
      session[:user_id] = @user.id
      # ブラウザにはCookieとして、サーバにはSessionとして、ログイン状態が維持される。
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
