// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from '@rails/ujs';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import { Dialog } from "application/helpers/dialog";
import PerfectScrollbar from "perfect-scrollbar";

Rails.start();
ActiveStorage.start();

// TODO: refactor!!!!
window.$ = require('jquery');
require('popper.js');
require('bootstrap');
require('slick-carousel');
require('simplebar');
require('utils/menu');
// require('selectize');
require('dropzone');
require('application');
require('perfect-scrollbar');

Dropzone.autoDiscover = false;

$(async () => {
    const [controller, action] = window.controllerContext;
    import(`../application/pages/${controller}`);

    // TODO: refactor!!!!
    const container = document.querySelector('.categories-menu');
    console.log('container', container);
    const ps = new PerfectScrollbar(container);
    document.querySelectorAll('.sidebar-sub-menu__content').forEach(content => {
        new PerfectScrollbar(content);
    });
    $('[data-toggle="tooltip"]').tooltip();
    //
    // function registerMenuListeners(menuSelector, menuItemSelector, submenuSelector, onSelect = null) {
    //     document.querySelectorAll(menuItemSelector).forEach((menuLink) => {
    //           const id = menuLink.getAttribute('data-id');
    //           const subMenu = document.querySelector(`${submenuSelector}[data-parent-id='${id}']`);
    //
    //           menuLink.addEventListener('mouseover', (e) => {
    //                document.querySelectorAll(`${submenuSelector}.show`).forEach(activeMenu => {
    //                    activeMenu.classList.remove('show');
    //                })
    //
    //               if (onSelect) {
    //                   onSelect();
    //               }
    //
    //               if (!subMenu) {
    //                   return;
    //               }
    //
    //               if (!subMenu.classList.contains('show')) {
    //                   subMenu.classList.add('show');
    //               }
    //           });
    //       });
    // }
    // registerMenuListeners('.categories-menu', '.categories-menu > .sidebar-menu-item', '.subcategories-menu', () => {
    //     document.querySelectorAll(`.teams-menu.show`).forEach(teamMenu => teamMenu.classList.remove('show'))
    // });


    // registerMenuListeners('.subcategories-menu', '.subcategories-menu > .sidebar-sub-menu-item', '.teams-menu');
    // document.querySelectorAll('.categories-menu > .sidebar-menu-item')
    //   .forEach((categoryMenu) => {
    //     const id = categoryMenu.getAttribute('data-id');
    //     const subMenu = document.querySelector(`.subcategories-menu[data-parent-id='${id}']`);
    //
    //     categoryMenu.addEventListener('mouseover', (e) => {
    //         const activeMenu = document.querySelector(`.subcategories-menu.show`);
    //         if (activeMenu) {
    //             activeMenu.classList.remove('show');
    //         }
    //
    //         if (!subMenu) {
    //             return;
    //         }
    //
    //         if (!subMenu.classList.contains('show')) {
    //             subMenu.classList.add('show');
    //         }
    //     });
    // });
    document.querySelectorAll('.categories-menu > .sidebar-menu-item')
      .forEach((categoryMenu) => {
        const id = categoryMenu.getAttribute('data-id');
        const subMenu = document.querySelector(`.subcategories-menu[data-parent-id='${id}']`);

        categoryMenu.addEventListener('mouseover', (e) => {
            const activeMenu = document.querySelector(`.subcategories-menu.show`);
            if (activeMenu) {
                activeMenu.classList.remove('show');
            }

            if (!subMenu) {
                return;
            }

            if (!subMenu.classList.contains('show')) {
                subMenu.classList.add('show');
            }
        });
    });
    // document.querySelectorAll('.sidebar-menu-item').forEach(menuItem => {
    //     const id = menuItem.getAttribute('id');
    //     const menu = menuItem.querySelector(`[data-dialog-id=${id}]`);
    //     new Dialog(id);
    //
    //     menu.querySelectorAll('.sidebar-sub-menu-item').forEach(submenu => {
    //         const submenuId = submenu.getAttribute('id');
    //         if (!submenuId) {
    //             return;
    //         }
    //         const subsubmenu = submenu.querySelector(`[data-dialog-id=${submenuId}]`);
    //         if (!subsubmenu) {
    //             return;
    //         }
    //         try {
    //             new Dialog(submenuId);
    //         } catch (e) {
    //             console.log('susubmenu', subsubmenu, submenuId)
    //         }
    //     })
    // });
});
// TODO: refactor
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
        pauseOnHover: true
    });

    $('#hero-info-carousel').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '#hero-carousel'
    });

    $('#hero-carousel').on('beforeChange', (_, __, ___, nextSlide) => makeHeroPageElementActive(nextSlide));
    $('.hero-nav__before').on('click', () => heroCarousel.slickPrev());
    $('.hero-nav__next').on('click', () => heroCarousel.slickNext());
    $('.hero-nav__page').on('click', (event) => {
        heroCarousel.slickGoTo(event.target.getAttribute('data-slide'))
    });
})