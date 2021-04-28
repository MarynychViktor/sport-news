require('cms/ia/ia.js')
import { createPopper } from '@popperjs/core';

$(document).ready(() => {
    $('#admin-menu').slick({
        arrows: true,
        variableWidth: true,
        infinite: false,
        prevArrow: '#admin-menu-prev',
        nextArrow: '#admin-menu-next'
    });
});
