class GroupsController < ApplicationController
  before_action :authenticate_user!

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.owned_groups.build(group_params)
    if @group.save
      redirect_to group_url(@group), notice: 'グループを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end
end
