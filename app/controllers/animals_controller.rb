class AnimalsController < ApplicationController

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
        lng: animal.longitude
      }

    end
    

    # @animals = Animal.all
    # @animal = Animal.new
    
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
    params.require(:animal).permit(:user_id, :name, :description, :photo_url, :hour_price, :address)
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

end
