import React from "react";
import { formatDate } from "../utils/date";

export class Comment extends React.Component<any, any> {
  constructor(props) {
    super(props);
    this.state = {
      showReplies: false
    };
    this.handleComment = this.handleComment.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
    this.toggleReplies = this.toggleReplies.bind(this);
    this.onDelete = this.onDelete.bind(this);
  }

  handleComment(event) {
    event.preventDefault();
    const {onCreate, comment} = this.props;
    onCreate(comment);
  }

  handleEdit(event) {
    event.preventDefault();
    const {onEdit, comment} = this.props;
    onEdit(comment);
  }

  onDelete(event) {
    event.preventDefault();
    const {onDelete, comment} = this.props;
    onDelete(comment);
  }

  toggleReplies(event) {
    event.preventDefault();
    this.setState(({showReplies}) => ({showReplies: !showReplies}));
  }

  render() {
    const {currentUser, comment: {user, children, ...comment}, onCreate, onEdit, likeComment, dislikeComment} = this.props;
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
                  <button className="comment-reactions" onClick={() => likeComment(comment)}>
                    <span className="material-icons-outlined comment-reactions-icon">
                      thumb_up
                    </span>
                    <span className="comment-like-count">{comment.likes}</span>
                  </button>
                </div>
                <div className={`comment-dislike ${comment.disliked_by_current_user && 'is-active'}`}>
                  <button className="comment-reactions" onClick={() => dislikeComment(comment)}>
                    <span className="material-icons-outlined comment-reactions-icon">
                      thumb_down
                    </span>
                    <span className="comment-dislike-count">{comment.dislikes}</span>
                  </button>
                </div>
              </div>
              <div className="comment-meta-actions">
                {authoredByCurrentUser && <a href="#" onClick={this.handleEdit} className="comment-meta-action comment-button">Edit</a>}
                <a href="#" onClick={this.handleComment} className="comment-meta-action comment-button">Comment</a>
                {authoredByCurrentUser && <a href="#" onClick={this.onDelete} className="comment-meta-action comment-button">Delete</a>}
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
                      <Comment currentUser={currentUser} onEdit={onEdit} comment={children} key={children.id}
                               onCreate={onCreate} likeComment={likeComment} dislikeComment={dislikeComment}/>)}
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
//
// export const CommentComponent = ({currentUser, comment, onClickComment}: any) => {
//   console.log('comment', comment, currentUser)
// }