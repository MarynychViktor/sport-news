import { createPopper, reference } from '@popperjs/core';

// TODO: remove if not used
// TODO: rename dropdown!
// interface DialogOption {
//   name: string;
//   options?: DialogOption[]
// }
//
// export class Dialog {
//   private static readonly dialogClass = 'app-dialog-menu';
//   private static readonly dialogVisibleClass = 'show';
//
//   private toggle: HTMLElement;
//   private dialogMenu: HTMLElement;
//   private popper: any;
//
//   private documentEventListener: any;
//
//   constructor(private toggleId, private options: any = {}) {
//     this.init();
//   }
//
//   private init() {
//     this.findDialogElements();
//     this.renderDialogMenu();
//     this.setupDialogListeners();
//   }
//
//   private findDialogElements() {
//     this.toggle = document.querySelector(`#${this.toggleId}`);
//     this.dialogMenu = document.querySelector(`[data-dialog-id=${this.toggleId}].${Dialog.dialogClass}`);
//
//     if (!this.toggle || !this.dialogMenu) {
//       throw new Error('Invalid selector provided');
//     }
//   }
//
//   private renderDialogMenu() {
//     this.popper = createPopper(this.toggle, this.dialogMenu, {
//       placement: 'right-start',
//       modifiers: [
//         {
//           name: 'eventListeners',
//           options: {
//             scroll: true,
//             resize: true
//           }
//         },
//         {
//           name: 'flip',
//           enabled: false
//         },
//         {
//           name: 'preventOverflow',
//           escapeWithReference: true
//         }
//       ],
//     });
//   }
//
//   private setupDialogListeners() {
//     this.toggle.addEventListener('click', this.onToggleClick.bind(this));
//     this.toggle.addEventListener('mouseover', () => {
//       this.popper.update();
//     });
//   }
//
//   private onToggleClick(_) {
//     if (this.dialogMenu.classList.contains(Dialog.dialogVisibleClass)) {
//       this.dialogMenu.classList.remove(Dialog.dialogVisibleClass);
//     } else {
//       this.dialogMenu.classList.add(Dialog.dialogVisibleClass);
//
//       const self = this;
//       this.documentEventListener = function (event) {
//         if (!event.target.closest(`.${Dialog.dialogClass}`)) {
//           if (self.dialogMenu.classList.contains(Dialog.dialogVisibleClass)) {
//             self.dialogMenu.classList.remove(Dialog.dialogVisibleClass);
//           }
//
//           document.removeEventListener('click', self.documentEventListener);
//         }
//       }
//
//       setTimeout(() => {
//         document.addEventListener('click', this.documentEventListener);
//       });
//     }
//   }
// }
