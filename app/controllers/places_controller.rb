class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :new, :create, :edit, :update]
  before_action :set_not_visited_place, only: [:show, :edit, :update]

  def show; end

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

  def edit; end

  def update
    if @place.update(place_params)
      redirect_to group_place_url(@group, @place)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def place_params
      params.require(:place).permit(:name, :description, :url)
    end

    def set_group
      @group = current_user.belonging_groups.find(params[:group_id])
    end

    def set_not_visited_place
      @place = @group.places.not_visited.find(params[:id])
    end
end
