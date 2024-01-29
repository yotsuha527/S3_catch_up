class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def create
    group = Group.new(group_params)
    if group.save
      group.add_user(current_user)
      redirect_to groups_path
    else
      redirect_to groups_path
    end
  end

  def show
    @book = Book.new
    @members = 0 #後で実装
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
  end

  private
  def group_params
    params.require(:group).permit(:owner_id, :name, :introduction, :group_image)
  end
end
