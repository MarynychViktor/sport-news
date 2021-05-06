export function customerMenu() {
  document.querySelectorAll('.categories-menu .category-menu-item')
    .forEach((menuLink) => {
      const id = menuLink.getAttribute('data-id');
      const subMenu = document.querySelector(`.subcategories-menu[data-parent-id='${id}']`);

      menuLink.addEventListener('mouseenter', (e) => {
        hideSubcategoryMenus();

        if (!subMenu)
          return;

        if (!subMenu.classList.contains('show'))
          subMenu.classList.add('show');
      });
    });

  document.querySelectorAll('.categories-menu').forEach(menu => {
    menu.addEventListener('mouseleave', (e) => {
      if (!(e as any).relatedTarget.closest('.subcategories-menu')) {
        hideSubcategoryMenus();
      }
    });
  })

  document.querySelectorAll('.subcategories-menu').forEach(menu => {
    menu.addEventListener('mouseleave', (e) => {
      if (!(e as any).relatedTarget.closest('.teams-menu')) {
        hideSubcategoryMenus();
      }
    });
  });

  document.querySelectorAll('.subcategories-menu .subcategory-menu-item')
    .forEach((menuLink) => {
      const id = menuLink.getAttribute('data-id');
      const subMenu = document.querySelector(`.teams-menu[data-parent-id='${id}']`);

      menuLink.addEventListener('mouseenter', (e) => {
        hideTeamMenus();

        if (!subMenu)
          return;

        if (!subMenu.classList.contains('show'))
          subMenu.classList.add('show');
      });
    });

  document.querySelectorAll('.teams-menu').forEach(menu => {
    menu.addEventListener('mouseleave', (e) => {
      hideTeamMenus();
      const {relatedTarget} = e as any
      if (!relatedTarget || !relatedTarget.closest('.subcategories-menu')) {
        hideSubcategoryMenus();
      }
    });
  });
}

function hideSubcategoryMenus() {
  document.querySelectorAll(`.subcategories-menu.show`).forEach(activeMenu => activeMenu.classList.remove('show'));
  hideTeamMenus();
}

function hideTeamMenus() {
  document.querySelectorAll(`.teams-menu.show`).forEach(activeMenu => activeMenu.classList.remove('show'));
}