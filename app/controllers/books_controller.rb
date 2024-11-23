class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      #indexで使ってるやつを全部セットしなおす。
      @user_temp = current_user
      @book_temp = Book.new(user_id: current_user.id)
      @book_all = Book.all
      render :index
      #renderは基本的にファイル名、つまりアクションしか指定できない。pathは不可
    end
  end

  def index
    @book = Book.new #エラー文用
    @user_temp = current_user
    @book_temp = Book.new(user_id: current_user.id)
    @book_all = Book.all
  end

  def show
    @book = Book.new #エラー文用
    @book_temp = Book.new(user_id: current_user.id)
    @book_posted = Book.find(params[:id])
    @user_temp = @book_posted.user
  end

  def edit
    @book = Book.new #エラー文用
    @book_posted = Book.find(params[:id])
    if @book_posted.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
   else
      @book_posted = Book.find(params[:id]) #入れなおさないとShowやBackのリンク先idが取得できない
      render :edit
   end
  end

  def destroy
    @book_posted = Book.find(params[:id])
    @book_posted.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  #ストロングパラメータ。bookモデルのtitle,bodyカラムだけ許可する
end
