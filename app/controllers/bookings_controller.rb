# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :set_booking, only: %w[show edit update]
  after_action :verify_authorized, only: :index, unless: :skip_pundit?
  skip_after_action :verify_policy_scoped, only: :index

  def show
    authorize @booking
    @bar = @booking.bar
  end

  def edit
    authorize @booking
  end

  def update
    @booking.update(booking_params)
    authorize @booking
    @booking.save
  end

  def create
    @booking = Booking.new(booking_params)
    @bar = Bar.find(params[:bar_id])
    @booking.user = current_user
    @booking.bar = @bar
    @booking.amount = @bar.price * @booking.guest_number
    @booking.state = "En cours"
    authorize @booking

    @booking.save
    redirect_to booking_path(@booking)
  end

  def index
    @user_bookings = current_user.bookings.order(starts_at: :desc)
    authorize @user_bookings
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(
      :amount,
      :starts_at,
      :ends_at,
      :guest_number,
      :state
    )
  end
end
