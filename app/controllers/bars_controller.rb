# frozen_string_literal: true

class BarsController < ApplicationController
  before_action :set_bar, only: %w[show edit update]

  def index
    @bars = policy_scope(Bar)
  end

  def show; end

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
    @bar.save
    redirect_to bar_path(@bar)
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
      :price
    )
  end
end
