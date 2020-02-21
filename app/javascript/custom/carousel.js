import "slick-carousel";
import "custom/carousel";
import $ from 'jquery'

const initSlick = () => {
  $(".variable-width").slick({
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    variableWidth: true

  });
};

export { initSlick };
