module UsersHelper
  # Helperとは、Viewでの処理を一部肩代わりするために存在する。
  
  def gravatar_url(user, options = { size: 80 })
    # gravatarとは、メールアドレスに対して自分のアバダー画像を登録するサービス。
    
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
