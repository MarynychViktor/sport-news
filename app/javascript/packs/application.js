// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

window.$ = require("jquery")
require("popper.js")
require("bootstrap")
require("slick-carousel")
require('simplebar')
require('utils/menu')
window.Sortable = require('sortablejs')
// const links = [
//     {name: 'HOME'},
//     {name: 'NBA', items: [{name: 'Test1', items: [{name: 'Test1'}, {name: 'Test2'}, {name: 'Test3'}, {name: 'Test4'}, {name: 'Test5'},]}, {name: 'Test2'}, {name: 'Test3'}, {name: 'Test4'}, {name: 'Test5'},]},
//     {name: 'SOCCER', items:[{name: 'Test1'}, {name: 'Test2'}, {name: 'Test3'}, {name: 'Test4'}, {name: 'Test5'},]},
//     {name: 'TEAM HUB', items: [{name: 'Test1'}, {name: 'Test2'}, {name: 'Test3'}, {name: 'Test4'}, {name: 'Test5'},]},
//     {name: 'LIFESTYLE', items: [{name: 'Test1'}, {name: 'Test2'}, {name: 'Test3'}, {name: 'Test4'}, {name: 'Test5'},]}
// ]
// console.log('createMenu', createMenu)
// $(document).ready(() => {
//     createMenu('#some-menu', links)
// })