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
    group.save
    redirect_to groups_path
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
