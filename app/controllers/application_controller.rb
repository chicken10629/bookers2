class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #deviseコントローラ使用時、アクション前にサインアップに必要なカラム使用許可を出す

  def after_sign_in_path_for(resource)
    user_path(resource.id)
    #users#showアクション
    #resourceはログインしたユーザーのモデルのヘルパーメソッドらしい。current_userと似たようなもの。
  end

  def after_sign_out_path_for(resource)
    root_path
    #とっぷぺーじ
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

end
