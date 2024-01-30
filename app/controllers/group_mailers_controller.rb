class GroupMailersController < ApplicationController
  def new
    @new_group_mail = GroupMail.new
    @group = Group.find(params[:group_id])
  end

  def create 
    @new_group_mail = GroupMail.new(str_params)     
    @new_group_mail.group_id = params[:group_id]
    @new_group_mail.save
    @group = Group.find(params[:group_id])
    @owner = User.find(@group.owner_id)
    @group.users.each do |user|
######  メイラーの呼び出し  ###########################################################
    GroupMailer.with(
    title: @new_group_mail.title, content: @new_group_mail.content, 
    owner_email: @owner.email, owner_name: @owner.name,               
    user_email: user.email
   ).send_mail.deliver_later
######################################################################################
    end

    redirect_to group_group_mailer_path(@group.id, @new_group_mail.id)
  end

  def show
    @mail = GroupMail.find(params[:id])
  end

private    
  def str_params 
    params.require(:group_mail).permit(:title, :content)
  end 
end
