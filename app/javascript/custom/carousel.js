import "slick-carousel";
import "custom/carousel";

const initSlick = () => {
  $(".variable-width").slick({
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
    variableWidth: true

  });
};

export { initSlick };
