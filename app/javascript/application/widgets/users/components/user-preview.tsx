import { User } from "../model/user";
import React from "react";

export const UserPreview = ({user}: {user: User}) => (
  <div className='user-preview'>
    <div className='user-preview__logo-wrapper'>
      <img src={user.photo.url}  className='user-preview__logo' alt=""/>
    </div>
    <div className='user-preview__name'>
      { user.first_name } { user.last_name }
    </div>
  </div>
);