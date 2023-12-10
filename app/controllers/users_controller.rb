class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
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
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
