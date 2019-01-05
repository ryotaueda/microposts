class ToppagesController < ApplicationController
  def index  #micropostの一覧表示
    if logged_in?
      @micropost = current_user.microposts.build  # form_for用
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])  #一覧表示用
    end
  end
end
