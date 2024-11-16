class BooksController < ApplicationController
  def new
    @books = Book.new
  end

  def create
    @books = Book.new(book_params)
    @books.user_id =current_user.id
    if @books.save
      redirect_to book_path(@books.id)
    else
      render books_path
    end
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user_id
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to users_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  #ストロングパラメータ。bookモデルのtitle,bodyカラムだけ許可する
end
