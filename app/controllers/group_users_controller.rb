class GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = current_user.belonging_groups.find(params[:group_id])
    @users = @group.users
  end
end
