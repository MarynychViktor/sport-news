export function renderAdminMenuSlider() {
  const menuEl = $('#admin-menu');

  if (menuEl.length) {
    menuEl.slick({
      arrows: true,
      variableWidth: true,
      infinite: false,
      prevArrow: '#admin-menu-prev',
      nextArrow: '#admin-menu-next'
    });
  }
}
