import React from "react";

import { UserMenu } from "./user-menu";
import { User } from "../model/user";
import { UserAction } from "./users-widget";
import { UserPreview } from "./user-preview";

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
    const {users, currentUser} = this.props;
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
            <th className='user-list-header-cell'>Actions</th>
          </tr>
        </thead>
        <tbody>{ userItems }</tbody>
      </table>
    )
  }
}