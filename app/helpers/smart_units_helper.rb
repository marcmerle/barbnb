# frozen_string_literal: true

module SmartUnitsHelper
  def sensible_distance(meters)
    return "#{meters} m" if meters < 1_000

    "#{meters / 1_000} km"
  end
end
