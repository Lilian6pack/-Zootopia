class AnimalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], :raise => false
  before_action :set_animal, only: [:show, :destroy]

  def index
    if params[:query].present?
      @animals = Animal.search_by_name(params[:query])
    else
      @animals = Animal.all
    end
    animals_geocoded = Animal.geocoded # returns flats with coordinates
    @markers = animals_geocoded.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { animal: animal }),
        image_url: helpers.asset_url('/images/mark.jpg') 
      }

    end
    

    # @animals = Animal.all
    # @animal = Animal.new
    
  end

  def show
    if current_user
      set_animal
    else
      redirect_to new_user_session_path
    end
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
