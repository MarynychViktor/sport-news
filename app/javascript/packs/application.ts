// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from '@rails/ujs';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
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
    (async () => {
        try {
            await import(`../application/pages/${controller}`);
        } catch (e) {
            console.log(`ooops. ../application/pages/${controller} not found`, action)
        }
    })()

    try {
        // TODO: refactor!!!!
        const container = document.querySelector('.categories-menu');
        console.log('container', container);
        const ps = new PerfectScrollbar(container);
        document.querySelectorAll('.sidebar-sub-menu__content').forEach(content => {
            new PerfectScrollbar(content);
        });
    } catch (e) {
        console.log('err', e)
    }

    $('[data-toggle="tooltip"]').tooltip();

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
});
// TODO: refactor
