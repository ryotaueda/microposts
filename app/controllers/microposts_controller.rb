class MicropostsController < ApplicationController
  before_action :require_user_logged_in  # MicropostsControllerの全アクションはログイン必須になる。
  before_action :correct_user, only: [:destroy]  # destroyアクションが実行される前にcorrect_userが実行される。
  
  def create  # 投稿を保存
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order('created_ad DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy  # 投稿を削除
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)  # このアクションが実行されたページに戻る。()内は、戻るべきページがない場合にroot_pathに戻る。
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user  # 削除しようとしているMicropostが本当にログインユーザが所有しているものか確認。
    @micropost = current_user.microposts.find_by(id: params[:id])  # ログインユーザ(current_user)が持つMicroposts限定で検索。
    unless @micropost  # nil判定。nilがfalseのときに実行。
      redirect_to root_url  # トップページに戻される。
    end
  end
end
