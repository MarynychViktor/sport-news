import React from 'react';
import ReactDOM from 'react-dom';

import { CommentsComponent } from "../application/widgets/comments";
import { ArticleCommentsApi } from "../application/widgets/comments/api/article-comments-api";

declare const window: Window & any;


document.addEventListener('DOMContentLoaded', () => {
  const node = document.querySelector('#comments');
  const {AppContext: {user}} = window;
  const commentableType = node.getAttribute('commentable-type');
  const commentable = node.getAttribute('commentable');
  if (!commentableType || !commentable) {
    throw new Error('Please make sure following attributes provided: [commentable-type], [commentable]')
  }

  if (commentableType != 'article') {
    throw new Error(`Unsupported commentable type: ${commentableType}`);
  }

  const apiClient = new ArticleCommentsApi(JSON.parse(commentable));

  ReactDOM.render(
    <CommentsComponent currentUser={user} apiClient={apiClient}/>,
    node,
  )
})
