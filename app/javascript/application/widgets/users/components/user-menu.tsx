import React from "react";
import Dropdown from "react-bootstrap/esm/Dropdown";

import { User } from "../model/user";
import { UserAction } from "./users-widget";

const UserMenuToggle = React.forwardRef<any>(({ children, onClick } : any, ref) => (
  <a href="" className='user-menu-toggle' ref={ref} onClick={(e) => {
      e.preventDefault();
      onClick(e);
    }}>
    {children}
  </a>
));

export const UserMenu = ({user, onAction}: {user: User, onAction: any}) => {
  const emitAction = (event, action) => {
    event.preventDefault();
    onAction(user, action);
  }

  return (
    <Dropdown>
      <Dropdown.Toggle as={UserMenuToggle}>Manage</Dropdown.Toggle>

      <Dropdown.Menu className='user-menu-dropdown'>
        {
          !user.admin && (user.blocked ?
            <Dropdown.Item className='user-menu-dropdown-item is-primary' href="#"
                           onClick={(e) => emitAction(e, UserAction.Activate)}>Activate</Dropdown.Item> :
            <Dropdown.Item className='user-menu-dropdown-item is-primary' href="#"
                           onClick={(e) => emitAction(e, UserAction.Block)}>Block</Dropdown.Item>)
        }
        {
          !user.blocked && ( user.admin ?
              <Dropdown.Item className='user-menu-dropdown-item is-success' href="#"
                             onClick={(e) => emitAction(e, UserAction.RemoveFromAdmin)}>Remove from admin</Dropdown.Item> :
              <Dropdown.Item className='user-menu-dropdown-item is-success' href="#"
                             onClick={(e) => emitAction(e, UserAction.MakeAdmin)}>Make as admin</Dropdown.Item>
          )
        }
        <Dropdown.Item className='user-menu-dropdown-item is-danger' href="#"
                       onClick={(e) => emitAction(e, UserAction.Delete)}>Delete</Dropdown.Item>
      </Dropdown.Menu>
    </Dropdown>
  );
}