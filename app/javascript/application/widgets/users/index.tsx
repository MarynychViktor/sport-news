import React from "react";
import ReactDOM from "react-dom";
import { UsersWidget } from "./components/users-widget";
const {AppContext: {user}} = window as any;

ReactDOM.render(
  <UsersWidget currentUser={user}/>,
  document.querySelector('#users')
);