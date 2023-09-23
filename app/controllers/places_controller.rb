class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create]

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.build(place_params)
    @place.group = @group
    if @place.save
      redirect_to group_path(@group)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def place_params
      params.require(:place).permit(:name, :description, :url)
    end

    def set_group
      @group = current_user.belonging_groups.find(params[:group_id])
    end
end
