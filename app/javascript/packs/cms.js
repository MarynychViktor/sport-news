require('cms/ia/ia')

$(document).ready(() => {
    const menuEl = $('#admin-menu');
    if (!menuEl.length) {
        return;
    }
    menuEl.slick({
        arrows: true,
        variableWidth: true,
        infinite: false,
        prevArrow: '#admin-menu-prev',
        nextArrow: '#admin-menu-next'
    });
});
