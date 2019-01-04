Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # ログイン機能
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # 新規登録機能
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end
