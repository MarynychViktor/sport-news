console.log('FILE CALLBACK FIRED')

let initialize = false;
$(document).ready(() => {

    // $(document).on('ready  page:load page:change', () => {
        console.log('ADMIN CALLBACK FIRED', initialize)
    if (initialize) {
        return
    }
    initialize = true;
        // const heroCarouselElement = $('#hero-carousel');
        // let heroCarousel;
        //
        // heroCarouselElement.on('init', (event, slick) => {
        //     heroCarousel = slick;
        //     makeHeroPageElementActive(slick.currentSlide);
        // });
        $('#admin-menu').slick({
            // slidesToShow: 1,
            // slidesToScroll: 1,
            arrows: true,
            variableWidth: true,
            infinite: false,
            prevArrow: '#admin-menu-prev',
            nextArrow: '#admin-menu-next'
            // fade: true,
        });

        // $('#hero-carousel').on('beforeChange', (_, __, ___, nextSlide) => makeHeroPageElementActive(nextSlide));
        // $('.hero-nav__before').on('click', () => heroCarousel.slickPrev());
        // $('.hero-nav__next').on('click', () => heroCarousel.slickNext());
        // $('.hero-nav__page').on('click', (event) => {
        //     heroCarousel.slickGoTo(event.target.getAttribute('data-slide'))
        // });
    // })
})

document.addEventListener('DOMContentLoaded', () => {
   console.log('DOM CONTENTE LOADED')
});