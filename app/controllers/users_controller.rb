class UsersController < ApplicationController


  def show
    @book = Book.new
    @user_temp = User.find(params[:id])
    @book_temp = Book.new(user_id: current_user.id)
    @book_posted = @user_temp.books
  end
  
  def edit
    #パスの数字がcurrent_user.idではないとき別ページへ飛ばす
    user_id = params[:id]
    if user_id.to_i != current_user.id
      #byebug確認したところ、user_idがstring型の"1"となっていた。
      redirect_to user_path(current_user.id)
    end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(current_user.id)
    else
       user_id = params[:id]
       render :edit
       #renderはアクション名　パス指定不可
    end
  end

  def index
    @book = Book.new #エラー文用
    @user_temp = current_user
    @book_temp = Book.new(user_id: current_user.id)
    @user_all = User.all
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction )
  end
  #アップデートするためのストロングパラメータを指定　userモデルのname,introduction,profile_image
  #入力必須項目はnameのみ　validatesをモデルに指定
end
