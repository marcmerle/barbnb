const init = () => {
  $(".variable-width").slick({
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 2,
    centerMode: true,
    variableWidth: true
  });
};

window.addEventListener('turbolinks:load', (e) => {
  init();
});
