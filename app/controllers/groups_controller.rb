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
    @group = Group.find(params[:id])
    if @group.group_join?(current_user)
      @flag = 0
    else
      @flag = 1
    end
    @members = @group.users
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update

  end
  
  def destroy
  end

  def add
    group = Group.find(params[:group_id])
    group.add_user(current_user)
    redirect_to groups_path
  end

  def leave
    group = Group.find(params[:group_id])
    group.leave_user(current_user)
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:owner_id, :name, :introduction, :group_image)
  end
end
