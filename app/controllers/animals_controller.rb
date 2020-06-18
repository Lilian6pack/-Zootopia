class AnimalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], :raise => false
  before_action :set_animal, only: [:show, :destroy]

  def index
    # list:
    if current_user
      if current_user.zoo
        @list = Animal.where(user_id: current_user.id).geocoded
      else
        @list = Animal.all
      end
    else
      @list = Animal.all
    end
    # search:
    if params[:query].present?
      @animals = @list.search_by_name(params[:query])
    else
      @animals = @list
    end
    # markers:
    @markers = @animals.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { animal: animal }),
        image_url: helpers.asset_url('/images/mark.jpg') 
      }
    end
  end

  def show
      set_animal
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user_id = current_user.id
    if @animal.save!
      redirect_to animal_path(@animal)
    else
      render 'new'
    end
  end

  def edit
    set_animal
  end

  def update 
    set_animal
    @animal.update(animal_params)

    redirect_to animal_path(@animal)
  end

  def destroy
    set_animal
    @animal.destroy
    redirect_to animals_path
  end

  private

  def animal_params
    params.require(:animal).permit(:user_id, :name, :description, :photo_url, :daily_price, :address)
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

end
