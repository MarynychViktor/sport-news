import React from "react";
import { UserRole } from "./users-widget";

export const ListHeader = ({usersCount, adminsCount, activeTab, onTabChange}) => {
  return (
    <div className='users-header'>
      <a href="#" className={`users-header-link ${activeTab == 'user' && 'is-active'}`} onClick={e => {
        e.preventDefault();
        onTabChange(UserRole.User);
      }}>Users ({usersCount})</a>
      <a href="#" className={`users-header-link ${activeTab == 'admin' && 'is-active'}`} onClick={e => {
        e.preventDefault();
        onTabChange(UserRole.Admin);
      }}>Admins ({adminsCount})</a>
    </div>
  )
}