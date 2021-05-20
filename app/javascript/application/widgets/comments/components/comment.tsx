import React from "react";
import { formatDate } from "../utils/date";
import { CommentAction } from "./comment-list";

export class Comment extends React.Component<any, any> {
  constructor(props) {
    super(props);
    this.state = {
      showReplies: false
    };
    this.toggleReplies = this.toggleReplies.bind(this);
  }

  handleActionRequested(event, name) {
    event.preventDefault();
    const {dispatchAction, comment} = this.props;
    dispatchAction(name, comment);
  }

  toggleReplies(event) {
    event.preventDefault();
    this.setState(({showReplies}) => ({showReplies: !showReplies}));
  }

  render() {
    const {currentUser, comment: {user, children, ...comment}, dispatchAction} = this.props;
    const {showReplies} = this.state;
    const authoredByCurrentUser = currentUser && currentUser.id == user.id;
    const hasChildren = children && children.length;

    return (
      <div className='comment-with-reply'>
        <div className="comment">
          <div className="comment-user">
            <div className="comment-user-avatar-wrapper">
              <img src={user.photo.url} alt="" className="comment-user-avatar"/>
            </div>
          </div>
          <div className="comment-content">
            <div className="comment-user-name">
              {user.first_name} {user.last_name}
            </div>
            <div className="comment-date">{formatDate(comment.created_at)}</div>
            <div className="comment-text">{comment.content}</div>
            <div className="comment-meta">
              <div className="comment-meta-feedback">
                <div className={`comment-like ${comment.liked_by_current_user && 'is-active'}`}>
                  <button className="comment-reactions" onClick={event => this.handleActionRequested(event, CommentAction.Like)}>
                    <span className="material-icons-outlined comment-reactions-icon">
                      thumb_up
                    </span>
                    <span className="comment-like-count">{comment.likes}</span>
                  </button>
                </div>
                <div className={`comment-dislike ${comment.disliked_by_current_user && 'is-active'}`}>
                  <button className="comment-reactions" onClick={event => this.handleActionRequested(event, CommentAction.Dislike)}>
                    <span className="material-icons-outlined comment-reactions-icon">
                      thumb_down
                    </span>
                    <span className="comment-dislike-count">{comment.dislikes}</span>
                  </button>
                </div>
              </div>
              <div className="comment-meta-actions">
                {
                  authoredByCurrentUser &&
                  <a href="#" className="comment-meta-action comment-button"
                     onClick={event => this.handleActionRequested(event, CommentAction.Edit)}>Edit</a>
                }
                <a href="#" className="comment-meta-action comment-button"
                   onClick={event => this.handleActionRequested(event, CommentAction.Reply)}>Comment</a>
                {
                  authoredByCurrentUser &&
                  <a href="#" className="comment-meta-action comment-button"
                     onClick={event => this.handleActionRequested(event, CommentAction.Delete)}>Delete</a>
                }
              </div>
            </div>
          </div>
        </div>
        <div className="comment-replies">
          {
            hasChildren ? (
              <React.Fragment>
                {!showReplies && <a href='#' className='link' onClick={this.toggleReplies}>Show replies</a>}
                {showReplies && (
                  <React.Fragment>
                    { children.map(children =>
                      <Comment currentUser={currentUser} dispatchAction={dispatchAction} comment={children}
                               key={children.id}/>)}
                    <a href='#' className='link' onClick={this.toggleReplies}>Hide replies</a>
                  </React.Fragment>
                )}
              </React.Fragment>
            ) : (<div/>)
          }
        </div>
      </div>
    );
  }
}