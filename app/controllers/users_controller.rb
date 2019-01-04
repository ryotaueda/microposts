class UsersController < ApplicationController
  
  # ログイン認証
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    # ユーザー一覧
    @users = User.all.page(params[:page])
  end

  def show
    # ユーザー詳細
    @user = User.find(params[:id])
  end

  def new
    # ユーザー登録フォーム
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Userのインスタンスを生成する時に、Strong Parameterが使用されている。
    # 保存に失敗しても、@userインスタンスは残っており、入力欄にはたった今失敗した文字列値があらかじめ入力された状態になる。
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
      # 処理をusers#showのアクションへと強制的に移動させるもので、createアクション実行後にさらにshowアクションが実行され、show.html.erbが呼ばれる。
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
      # users/new.html.erbを表示されるだけ（users#newのアクションは実行しない）。
      # createに対応するviewは用意する必要はない。
    end
  end
  
  private
  # 以下Strong Parameter＝private以降で定義されたメソッドがアクションではなく、このクラス内でのみ使用することを明示している。
  # 必要なパラメータを把握して、送信されてきたデータを精査する。
  # セキュリティ対策
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # params.require(:user) でUserモデルのフォームから得られるデータに関するものだと明示。
    # permit.(〜〜) で必要なカラムだけを選択している。
  end
  
end
