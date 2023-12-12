class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
    @user = @book.user
    @messengers = Messenger.where(user_id: @user.id)
    @current_messengers = Messenger.where(user_id: current_user.id)
    unless @user.id == current_user.id
      @is_room = false
      @messengers.each do |messenger| # Roomが作られているか二重ループで検索
        @current_messengers.each do |current_messenger|
          if messenger.room_id == current_messenger.room_id # Roomが作られていればroom_createにtrueを入れループを抜ける
            @is_room = true
            @room_id = messenger.room_id
            break;
          end
        end
      end
    end
    unless @is_room # Roomが作られていなければ新規で作る
      @room = Room.new
      @messenger = Messenger.new
    end
    @book_new = Book.new
  end

  def index
    time_end = Time.current.at_end_of_day
    week = (time_end - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).sort_by {|book| book.favorited_users.includes(:favorites).where(created_at: week...time_end).size}.reverse
    #
    p @books
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
