// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from '@rails/ujs';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import { Dialog } from "application/helpers/dialog";

Rails.start();
ActiveStorage.start();

window.$ = require('jquery');
require('popper.js');
require('bootstrap');
require('slick-carousel');
require('simplebar');
require('utils/menu');
// require('selectize');
require('dropzone');
require('application');

Dropzone.autoDiscover = false;

$(async () => {
    const [controller, action] = window.controllerContext;
    import(`../application/pages/${controller}`);


    //
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
