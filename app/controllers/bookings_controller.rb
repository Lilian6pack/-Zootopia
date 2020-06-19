class BookingsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def new
    if current_user
      @booking = Booking.new
    @animal = Animal.find(params[:animal_id])
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to animal_booking_path(@booking.animal.id, @booking.id)
    else

      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @nb_of_days = (@booking.end_date - @booking.start_date).numerator
    @total_price = @booking.animal.daily_price * @nb_of_days
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :animal_id)
  end
end
