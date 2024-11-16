class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @book = Book.new(user_id: @user.id)
    @books = Book.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

end
