console.log('FILE CALLBACK FIRED')

require('admin/ia/ia.js')

$(document).ready(() => {
    $('#admin-menu').slick({
        arrows: true,
        variableWidth: true,
        infinite: false,
        prevArrow: '#admin-menu-prev',
        nextArrow: '#admin-menu-next'
    });
});
