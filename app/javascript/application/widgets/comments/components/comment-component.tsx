import React from "react";
import { formatDate } from "../utils/date";

export class CommentComponent extends React.Component<any, any> {
  constructor(props) {
    super(props);
    this.handleComment = this.handleComment.bind(this);
    this.handleEdit = this.handleEdit.bind(this);
  }

  handleComment(event) {
    event.preventDefault();
    const {onReply, comment} = this.props;
    onReply(comment);
  }

  handleEdit(event) {
    event.preventDefault();
    const {onEdit, comment} = this.props;
    onEdit(comment);
  }

  render() {
    const {currentUser, comment: {user, ...comment}, onReply, onEdit} = this.props;
    const authoredByCurrentUser = currentUser && currentUser.id == user.id;

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
                <div className="comment-like">
                  <button className="comment-reactions">
                <span className="material-icons-outlined comment-reactions-icon">
                  thumb_up
                </span>
                    <span className="comment-like-count">0</span>
                  </button>
                </div>
                <div className="comment-dislike">
                  <button className="comment-reactions">
                <span className="material-icons-outlined comment-reactions-icon">
                  thumb_down
                </span>
                    <span className="comment-dislike-count">0</span>
                  </button>
                </div>
              </div>
              <div className="comment-meta-actions">
                {authoredByCurrentUser && <a href="#" onClick={this.handleEdit} className="comment-meta-action comment-button">Edit</a>}
                <a href="#" onClick={this.handleComment} className="comment-meta-action comment-button">Comment</a>
                {authoredByCurrentUser && <a href="#" className="comment-meta-action comment-button">Delete</a>}
              </div>
            </div>
          </div>
        </div>
        <div className="comment-replies">
          { (comment.children || []).map(children => <CommentComponent currentUser={currentUser} onEdit={onEdit}
                                                                       comment={children} key={children.id}
                                                                       onReply={onReply}/>)}
        </div>
      </div>
    );
  }
}
//
// export const CommentComponent = ({currentUser, comment, onClickComment}: any) => {
//   console.log('comment', comment, currentUser)
// }