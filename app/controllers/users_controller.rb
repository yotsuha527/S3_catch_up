class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    # 記録系
    @today = @user.books.where('created_at > ?', Date.today).count
    @yesterday = @user.books.where('created_at < ?', Date.today).where('created_at > ?', Date.yesterday).count
    @week = @user.books.where('created_at > ?', Date.today-7.days).count
    @prev_week = @user.books.where('created_at < ?', Date.today-7.days).where('created_at > ?', Date.today-14.days).count
    # 日毎の記録
    if @yesterday == 0
      @day_diff = "前日の投稿が0件の為計算できません。"
    elsif @today == 0
      @day_diff = "本日の投稿が0件の為計算できません。"
    else
      @day_diff = @today / @yesterday
    end
    # 週毎の記録
    if @prev_week == 0
      @week_diff = "前週の投稿が0件の為計算できません。"
    elsif @week == 0
      @week_diff = "今週の投稿が0件の為計算できません。"
    else
      @week_diff = @week / @prev_week
    end
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
