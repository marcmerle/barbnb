# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @top_bars = Bar.all.sample(3)
  end
end
