# frozen_string_literal: true

class BarsController < ApplicationController
  before_action :set_bar, only: %w[show edit update]
  skip_before_action :authenticate_user!, only: %w[index show]

  def index
    @query = params[:query]
    if params[:query].present?
      @bars = policy_scope(Bar.near(params[:query], 1))
      @distance = @bars.map do |bar|
        distance(bar)
      end
    else
      @bars = policy_scope(Bar)
    end
    @markers = @bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { bar: bar }),
        image_url: helpers.asset_url('barbie.png')
      }
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @bar = Bar.new
    authorize @bar
  end

  def create
    @bar = Bar.new(bar_params)
    @bar.owner = current_user
    authorize @bar
    if @bar.save
      redirect_to bar_path(@bar)
    else
      render :new
    end
  end

  def edit; end

  def update
    @bar.update(bar_params)
    authorize @bar
    @bar.save
    redirect_to bar_path(@bar)
  end

  def distance(bar)
    if @query
      position = Geocoder.search(@query).first
    else
      position = Geocoder.search("16 villa Gaudelet").first
    end
    dist = Geocoder::Calculations.distance_between(position.coordinates, [bar.latitude, bar.longitude])
    dist * 1_000
  end

  private

  def set_bar
    @bar = Bar.find(params[:id])
    authorize @bar
  end

  def bar_params
    params.require(:bar).permit(
      :name,
      :address,
      :capacity,
      :opening_start,
      :opening_end,
      :description,
      :price,
      photos: []
    )
  end
end
