function makeHeroPageElementActive(page) {
    const activeElement = document.querySelector('.hero-nav__page.active');
    if (activeElement) {
        activeElement.classList.remove('active')
    }

    const pageLabels = document.querySelectorAll('.hero-nav__page');
    pageLabels[page].classList.add('active')
}

$(document).ready(() => {
    const heroCarouselElement = $('#hero-carousel');
    let heroCarousel;

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
    })
    $('#hero-info-carousel').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '#hero-carousel'
    })

    $('#hero-carousel').on('beforeChange', (_, __, ___, nextSlide) => makeHeroPageElementActive(nextSlide));
    $('.hero-nav__before').on('click', () => heroCarousel.slickPrev());
    $('.hero-nav__next').on('click', () => heroCarousel.slickNext());
    $('.hero-nav__page').on('click', (event) => {
        heroCarousel.slickGoTo(event.target.getAttribute('data-slide'))
    });
})