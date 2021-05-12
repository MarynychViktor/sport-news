
export function initHeroCarousel() {
  let heroCarousel;
  const heroCarouselElement: any = $('#hero-carousel');

  if (!heroCarouselElement.length) {
    return;
  }

  heroCarouselElement.on('init', (event, slick) => {
    heroCarousel = slick;
    makeHeroPageElementActive(slick.currentSlide);
  });

  heroCarouselElement.slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '#hero-info-carousel',
    autoplay: true,
    autoplaySpeed: 2000,
    pauseOnHover: true
  });

  ($('#hero-info-carousel') as any).slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '#hero-carousel'
  });

  heroCarouselElement.on('beforeChange', (_, __, ___, nextSlide) => makeHeroPageElementActive(nextSlide));
  $('.hero-nav__before').on('click', () => heroCarousel.slickPrev());
  $('.hero-nav__next').on('click', () => heroCarousel.slickNext());
  $('.hero-nav__page').on('click', (event) => {
    heroCarousel.slickGoTo(event.target.getAttribute('data-slide'))
  });
}


function makeHeroPageElementActive(page) {
  const activeElement = document.querySelector('.hero-nav__page.active');
  if (activeElement) {
    activeElement.classList.remove('active')
  }

  const pageLabels = document.querySelectorAll('.hero-nav__page');
  pageLabels[page].classList.add('active')
}
