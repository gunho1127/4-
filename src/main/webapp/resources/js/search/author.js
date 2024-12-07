$(document).ready(function () {
  authorSwiperInit(); // page-author swiper init
});

/**
 * swiper init
 */
function authorSwiperInit() {
  const swiper = new Swiper(".swiper", {
    loop: true,
    slidesPerView: 4,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });
}