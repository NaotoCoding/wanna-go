class BelongingGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @belonging_groups = current_user.belonging_groups
  end
end
