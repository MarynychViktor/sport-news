import React from "react";

import './users-widget.sass';
import { UsersList } from "./users-list";
import { UsersApi } from "../api/users-api";
import { Pagination } from "react-bootstrap";
import { ListHeader } from "./list-header";

export enum UserRole {
  User = 'user',
  Admin = 'admin'
}

export enum UserAction {
  Activate,
  Block,
  Delete,
  MakeAdmin,
  RemoveFromAdmin
}

const DEFAULT_QUERY = {
  page: 1,
  limit: 10,
  role: UserRole.User,
}

export class UsersWidget extends React.Component<any, any>{
  private api = new UsersApi();

  constructor(props) {
    super(props);
    this.state = {
      users: [],
      total: 0,
      lastPage: false,
      query: DEFAULT_QUERY
    }
    this.onTabChange = this.onTabChange.bind(this);
    this.listUsers = this.listUsers.bind(this);
    this.prevPage = this.prevPage.bind(this);
    this.nextPage = this.nextPage.bind(this);
    this.onChange = this.onChange.bind(this);
  }

  componentDidMount() {
    this.listUsers();
  }

  listUsers() {
    const {query} = this.state;

    this.api.listUsers(query).subscribe(({total, data: users, last_page: lastPage}) =>{
      this.setState({users, total, lastPage, query: {...query}});
    });
  }

  prevPage() {
    this.setState(({query}) => ({query: {...query, page: query.page - 1}}), () => this.listUsers());
  }

  nextPage() {
    this.setState(({query}) => ({query: {...query, page: query.page + 1}}), () => this.listUsers());
  }

  onTabChange(tab: UserRole) {
    const {query: {role}} = this.state;

    if (role === tab) {
      return;
    }

    this.setState({users: [], lastPage: false, query: {...DEFAULT_QUERY, role: tab}}, () => this.listUsers());
  }

  onChange() {
    this.listUsers();
  }

  render() {
    const {currentUser} = this.props;
    const {users, total, query: {role, page, limit} ,lastPage} = this.state;
    const from = (page - 1) * limit;
    const offset = users.length;

    return (
      <div>
        <ListHeader adminsCount={0} usersCount={0} activeTab={role} onTabChange={this.onTabChange}/>
        <div className='user-list-wrapper'>
          <UsersList users={users} currentUser={currentUser} api={this.api} onChange={this.onChange}/>
          <div className='user-list-paginator'>
            <div className='user-list-paginator-label'>{offset > 0 ? from + 1 : from}-{from + offset} of {total}</div>
            <Pagination className='user-list-paginator-nav' size="sm">
              <Pagination.Prev disabled={page === 1} onClick={this.prevPage}/>
              <Pagination.Next disabled={lastPage} onClick={this.nextPage}/>
            </Pagination>
          </div>
        </div>
      </div>
    )
  }
}