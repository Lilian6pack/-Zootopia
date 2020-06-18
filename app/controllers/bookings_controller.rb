class BookingsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def new
    @booking = Booking.new
    @animal = Animal.find(params[:animal_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to animal_booking_path(@booking.animal.id, @booking.id)
    else
      raise
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :animal_id)
  end
end
