module CarouselHelper
  def carousel_for(images)
    Carousel.new(self, images).html
  end

  class Carousel
    def initialize(view, images)
      @view, @images = view, images
    end

    def html
      # TO FILL IN
    end

    private

    attr_accessor :view, :images
  end
end
