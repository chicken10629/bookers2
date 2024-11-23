class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  #top、aboutアクションを除きログイン済みかどうか確認する
  before_action :configure_permitted_parameters, if: :devise_controller?
  #deviseコントローラ使用時、アクション前にサインアップに必要なカラム使用許可を出す

  

  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    user_path(resource)
    #users/showアクションを実行するらしい
    #エラー出る理由は
  end
  
  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome! You have signed in successfully."
    user_path(resource.id)
    #users#showアクション
    #resourceはログインしたユーザーのモデルのヘルパーメソッドらしい。current_userと似たようなもの。
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "See you! You have signed out successfully."
    root_path
    #とっぷぺーじ
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
