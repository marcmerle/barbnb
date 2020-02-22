# frozen_string_literal: true

class BarsController < ApplicationController
  before_action :set_bar, only: %w[show edit update]
  skip_before_action :authenticate_user!, only: %w[index show]

  def index
    @query = params[:query]
    @bars = @query.present? ? set_policy_scope : policy_scope(Bar)
    compute_distance

    @markers = create_markers(@bars)
  end

  def owner_index
    owner_bookings = current_user.bars.map { |bar| bar.bookings.count }.min
    if current_user.bars.empty?
      @bars = []
    elsif owner_bookings.zero?
      @bars = current_user.bars
    else
      @bars = current_user.bars.sort_by do |bar|
        bar.bookings.order(starts_at: :desc).limit(1).first.starts_at.to_i
      end
    end
    authorize @bars
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

  private

  def compute_distance
    position = @query.present? ? Geocoder.search(@query).first : Geocoder.search("16 villa Gaudelet").first
    @bars.each do |bar|
      bar.distance = (1_000 * Geocoder::Calculations.distance_between(
        position.coordinates,
        [bar.latitude, bar.longitude]
      )).round
    end
  end

  def create_markers(bars)
    bars.map do |bar|
      {
        lat: bar.latitude,
        lng: bar.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { bar: bar }),
        image_url: helpers.asset_url('barbie.png')
      }
    end
  end

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

  def set_policy_scope(distance = 1)
    bar_distance = Bar.near(@query, distance)
    if bar_distance.present?
      policy_scope(bar_distance)
    else
      new_dist = distance < 5 ? 1 : 100
      set_policy_scope(distance + new_dist)
    end
  end
end
