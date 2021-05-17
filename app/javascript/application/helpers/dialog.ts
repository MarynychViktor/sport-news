import { createPopper, reference } from '@popperjs/core';
import { fromEvent } from "rxjs";
import PerfectScrollbar from "perfect-scrollbar";

// TODO: remove if not used
// TODO: rename dropdown!

export class Menu {
  private activeSubmenu: Menu;
  private activeItem: any;
  private menuElement: HTMLElement;
  private popper: any;
  private target: HTMLElement;
  private childMenus: {[key: number]: Menu} = {};
  private items: HTMLElement[] = [];
  private visible = false;

  private static readonly menuClass = 'app-menu-section';
  private static readonly menuWrapperClass = 'app-menu-section-wrapper';
  private static readonly menuActiveClass = 'active';
  private static readonly menuItemClass = 'app-menu-item';
  private static readonly menuItemWithSubmenuClass = 'has-submenu';
  private static readonly menuItemActiveClass = 'active';
  private static readonly menuItemLinkClass = 'app-menu-item-link';
  private static readonly menuDepthAttr = 'data-depth';
  private static readonly menuItemIndexAttr = 'data-item-index';

  constructor(private selectorOrTarget: any, private config: any, private parent: Menu = null) {
    this.resolveTargetElement();
    this.createMenuElement();
    this.setupOpenEventListener();
  }

  getDepth() {
    return this.parent ? this.parent.getDepth() + 1 : 0;
  }

  private resolveTargetElement() {
    this.target = typeof this.selectorOrTarget === 'string' ?
      document.querySelector(this.selectorOrTarget) :
      this.selectorOrTarget;
  }

  private setupOpenEventListener() {
    if (!this.parent) {
      this.target.addEventListener('click', () => {
        if (this.visible) {
          return;
        }
        this.visible = true;
        this.showMenu();
      });
    }
  }
  private createMenuElement() {
    this.menuElement = this.createElement('div', [Menu.menuWrapperClass]);
    const itemsList = this.createElement('ul', [Menu.menuClass], [{name: Menu.menuDepthAttr, value: this.getDepth()}])

    this.config.items.forEach((configItem, index) => {
      const itemElement = this.createElement('li', [Menu.menuItemClass], [{name: Menu.menuItemIndexAttr, value: index}] );
      const itemLinkElement = this.createElement('a', [Menu.menuItemLinkClass]);
      itemLinkElement.innerText = configItem.text;
      itemElement.append(itemLinkElement);

      this.items.push(itemElement);

      if (configItem.items) {
        itemElement.classList.add(Menu.menuItemWithSubmenuClass);
        this.childMenus[index] = new Menu(itemElement, {items: configItem.items}, this);
      }

      itemElement.addEventListener('mouseenter', () => {
        this.removeActiveItemHighlight();
        this.highlightItemAt(index);
      });
      itemElement.addEventListener('click', () => {
        if (configItem.click) {
          configItem.click();
        }
        this.destroy();
      });

      itemsList.append(itemElement);
    });

    this.menuElement.append(itemsList);
    this.registerMenuLeaveListener();

    document.body.append(this.menuElement);
    new PerfectScrollbar(this.menuElement);
  }

  private initMenuElements() {
    this.menuElement = this.createElement('div', [Menu.menuWrapperClass]);
    const itemsList = this.createElement('ul', [Menu.menuClass], [{name: Menu.menuDepthAttr, value: this.getDepth()}])

    this.config.items.forEach((configItem, index) => {
      const itemElement = this.createElement('li', [Menu.menuItemClass], [{name: Menu.menuItemIndexAttr, value: index}] );
      const itemLinkElement = this.createElement('a', [Menu.menuItemLinkClass]);
      itemLinkElement.innerText = configItem.text;
      itemElement.append(itemLinkElement);

      this.items.push(itemElement);

      if (configItem.items) {
        itemElement.classList.add(Menu.menuItemWithSubmenuClass);
        this.childMenus[index] = new Menu(itemElement, {items: configItem.items}, this);
      }

      itemElement.addEventListener('mouseenter', () => {
        this.removeActiveItemHighlight();
        this.highlightItemAt(index);
      });
      itemElement.addEventListener('click', () => {
        if (configItem.click) {
          configItem.click();
        }
        this.destroy();
      });

      itemsList.append(itemElement);
    });

    this.menuElement.append(itemsList);
    this.registerMenuLeaveListener();

    document.body.append(this.menuElement);
    new PerfectScrollbar(this.menuElement);
  }

  private registerMenuLeaveListener() {
    this.menuElement.addEventListener('mouseleave', (e) => {
      e.preventDefault();
      const menuWrapper = (e.relatedTarget as any).closest(`.${Menu.menuWrapperClass}`);

      if (menuWrapper) {
        const menuSection = menuWrapper.querySelector(`.${Menu.menuClass}`);
        const depth = parseInt(menuSection.getAttribute(Menu.menuDepthAttr))

        if (depth < this.getDepth()) {
          this.destroy();
          return;
        }

        return;
      } else {
        if (this.parent) {
          this.parent.outOfPopupRange();
        } else {
          this.destroy();
        }
      }
    });
  }

  private highlightItemAt(index) {
    const item = this.items[index];
    item.classList.add(Menu.menuItemActiveClass);
    this.activeItem = item;

    const menu = this.childMenus[index];
    if (menu) {
      this.activeSubmenu = menu;
      menu.showMenu();
    }
  }

  private removeActiveItemHighlight() {
    if (this.activeItem) {
      this.activeItem.classList.remove(Menu.menuItemActiveClass);
    }

    if (this.activeSubmenu) {
      this.activeSubmenu.destroy();
    }
  }

  destroy() {
    this.visible = false;
    this.removeActiveItemHighlight();
    this.popper.destroy();
  }

  outOfPopupRange() {
    this.destroy();

    if (this.parent) {
      this.parent.outOfPopupRange();
    }
  }

  showMenu() {
    const {offsetX, offsetY} = this.config;
    this.popper = createPopper(this.target, this.menuElement, {
      placement: 'right-start',
      modifiers: [
        {
          name: 'flip',
          enabled: false
        },
        {
          name: 'offset',
          options: {
            offset: [offsetY ? offsetY : 0, offsetX ? offsetX : -1],
          },
        }
      ],
    })
  }

  private createElement(tag: string, classes: string[] = [], attributes: { name: string, value: any }[] = []) {
    const el = document.createElement(tag);
    attributes.forEach(({name, value}) => el.setAttribute(name, value));
    classes.forEach((className) => el.classList.add(className));
    return el;
  }
}
