// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from '@rails/ujs';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import PerfectScrollbar from "perfect-scrollbar";

declare const window: Window & any;
declare const Dropzone: any;

Rails.start();
ActiveStorage.start();

window.$ = require('jquery');
require('popper.js');
require('bootstrap');
require('slick-carousel');
require('simplebar');
require('utils/menu');
require('dropzone');
require('application');
require('perfect-scrollbar');

Dropzone.autoDiscover = false;

window.setApplicationContext = function (jsonData) {
  const {user, request} = JSON.parse(jsonData);
  window.AppContext = {user, request}
}

$(async () => {
  const {controller, action} = window.AppContext.request;
  (async () => {
    try {
      // @ts-ignore
      await import(`../application/pages/${controller}`);
    } catch (e) {
      console.log('')
      console.log(`ooops. ../application/pages/${controller} not found`)
    }
  })().then()

  const container = document.querySelector('.categories-menu');

  if (container) {
    new PerfectScrollbar(container);
    document.querySelectorAll('.sidebar-sub-menu__content').forEach(content => new PerfectScrollbar(content));
  }

  ($('[data-toggle="tooltip"]') as any).tooltip();

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
