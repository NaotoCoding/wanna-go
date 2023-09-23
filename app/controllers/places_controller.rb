class PlacesController < ApplicationController
  before_action :authenticate_user!

  def new
    @place = Place.new
  end

  def create
    group = current_user.belonging_groups.find(params[:group_id])
    @place = current_user.places.build(place_params)
    @place.group = group
    if @place.save
      redirect_to group_path(group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def place_params
      params.require(:place).permit(:name, :description, :url)
    end
end
