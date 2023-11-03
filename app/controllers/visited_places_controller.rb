class VisitedPlacesController < ApplicationController
  before_action :authenticate_user!

  def create
    group = current_user.belonging_groups.find(params[:group_id])
    place = group.places.not_visited.find(params[:place_id])
    place.visited!(current_user)
    redirect_to group_path(group), notice: "#{place.name}を行った場所に登録しました"
  end
end
