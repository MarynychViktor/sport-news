import React from "react";

import { UserMenu } from "./user-menu";
import { User } from "../model/user";
import { UserAction } from "./users-widget";
import { UserPreview } from "./user-preview";
import Dropdown from "react-bootstrap/esm/Dropdown";

const ActionsFilterToggle = React.forwardRef<any>(({ children, onClick } : any, ref) => (
  <a href="" className="user-actions-filter" ref={ref} onClick={(e) => {
    e.preventDefault();
    onClick(e);
  }}>
    {children}
  </a>
));

export class UsersList extends React.Component<any, any>{
  constructor(props) {
    super(props);
    this.onAction = this.onAction.bind(this);
  }

  onAction(user: User, action: UserAction) {
    const {api, onChange} = this.props;

    switch (action) {
      case UserAction.Activate:
        api.activate(user).subscribe(() => onChange());
        break;
      case UserAction.Block:
        api.block(user).subscribe(() => onChange());
        break;
      case UserAction.Delete:
        api.delete(user).subscribe(() => onChange());
        break;
      case UserAction.MakeAdmin:
        api.makeAdmin(user).subscribe(() => onChange());
        break;
      case UserAction.RemoveFromAdmin:
        api.removeAdmin(user).subscribe(() => onChange());
        break;
      default:
        throw new Error(`Unknown action ${action}`);
    }
  }

  render() {
    const {users, currentUser, changeOrder} = this.props;
    const userItems = users.map(user => (
      <tr key={user.id}>
        <td className='user-list-cell'><UserPreview user={user}/></td>
        <td className='user-list-cell'>
          <div className={`user-status ${!user.blocked && 'is-active'}`}>{ user.blocked ? 'Blocked' : 'Active' }</div>
        </td>
        <td className='user-list-cell'>
          { currentUser.id !== user.id ? <UserMenu onAction={this.onAction} user={user}/> : <div>-</div> }
        </td>
      </tr>
    ));

    return (
      <table style={{width: '100%'}}>
        <thead>
          <tr>
            <th className='user-list-header-cell'>Name</th>
            <th className='user-list-header-cell'>Status</th>
            <th className='user-list-header-cell'>
              <div className='user-actions'>
                <span className='user-actions__title'>Actions</span>
                <Dropdown>
                  <Dropdown.Toggle as={ActionsFilterToggle}>
                    <span className="material-icons">filter_alt</span>
                  </Dropdown.Toggle>

                  <Dropdown.Menu className='user-actions-dropdown'>
                    <Dropdown.Header className='user-actions-dropdown-header'>Sort by</Dropdown.Header>
                    <Dropdown.Divider className='user-actions-dropdown-divider'/>
                    <Dropdown.Item className='user-actions-dropdown-item is-danger'>Active</Dropdown.Item>
                    <Dropdown.Item className='user-actions-dropdown-item is-danger'>Blocked</Dropdown.Item>
                    <Dropdown.Item className='user-actions-dropdown-item is-danger'>Online</Dropdown.Item>
                    <Dropdown.Item className='user-actions-dropdown-item is-danger'>Offline</Dropdown.Item>
                  </Dropdown.Menu>
                </Dropdown>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>{ userItems }</tbody>
      </table>
    )
  }
}