class BarsController < ApplicationController
  before_action :set_bar, only: %w[show edit update]

  def index
    @bars = Bar.all
  end

  def show; end

  def new
    @bar = Bar.new
  end

  def create
    @bar = Bar.new(bar_params)
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
