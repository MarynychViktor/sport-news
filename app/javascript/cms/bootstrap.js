import { Pages } from "./pages";
import { initAdminMenu } from './helpers';


$(document).ready(() => {
  initAdminMenu();
  Pages.forEach(p => p.init());
});
