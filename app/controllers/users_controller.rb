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
      @day_diff = 0
    elsif @today == 0
      @day_diff = 0
    else
      @day_diff = (@today.to_f / @yesterday.to_f) * 100
    end
    # 週毎の記録
    if @prev_week == 0
      @week_diff = 0
    elsif @week == 0
      @week_diff = 0
    else
      @week_diff = (@week.to_f / @prev_week.to_f) * 100
    end
    # 7日毎の記録
    @day = 6
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

  def date_data
    user = User.includes(:books).find(params[:user_id])
    date = Date.parse(params[:created_at])
    @books = user.books.where(created_at: date.all_day)

    p user
    p date
    p @books

    render :date_data
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
