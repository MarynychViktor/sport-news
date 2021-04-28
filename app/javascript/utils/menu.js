const menuClass = 'app-ml-menu';
const menuItemClass = 'app-ml-menu-item';
const menuItemLinkClass = 'app-ml-menu-item-link';
const subMenuCLass = 'app-ml-submenu';

export function createMenu(selector, entries) {
    const root = document.createElement('ul');
    root.classList.add(menuClass);

    entries.forEach(i => addEntry(i, root));
    selector.append(root)

    function addEntry(entry, container) {
        const item = document.createElement('li');
        item.classList.add(menuItemClass);
        const link = document.createElement('a');
        link.textContent = entry.name;

        link.classList.add(menuItemLinkClass);
        item.appendChild(link);

        if (entry.items && entry.items.length) {
            const subMenu = document.createElement('ul');
            subMenu.classList.add(subMenuCLass);

            entry.items.forEach(ch => addEntry(ch, subMenu));
            link.appendChild(subMenu);
        }

        container.appendChild(item);
    }
}

$.fn.createMenu = function (links) {
    createMenu(this, links)
}
