import React from "react";
import { Comment } from "../model/comment";
import { Comment as CommentComponent } from "./comment";
import { ModalComponent } from "./modal-component";
import { CommentFormComponent } from "./comment-form-component";

export enum CommentAction {
  Like,
  Dislike,
  Reply,
  Edit,
  Create,
  Update,
  Delete
}

export class CommentList extends React.Component<any, any> {
  constructor(props) {
    super(props);

    this.state = {threadId: null, parentId: null, errors: null, showModal: false, editedComment: null};
    this.updateComment = this.updateComment.bind(this);
    this.createComment = this.createComment.bind(this);
    this.handleHideModal = this.handleHideModal.bind(this);
    this.handleCommentAction = this.handleCommentAction.bind(this);
  }

  handleCommentAction(action: CommentAction, comment: Comment) {
    const {apiClient} = this.props;

    switch (action) {
      case CommentAction.Reply:
        this.setState({threadId: comment.thread_id || comment.id, parentId: comment.id, showModal: true,
                             editedComment: null});
        break;
      case CommentAction.Edit:
        this.setState({editedComment: comment, showModal: true});
        break;
      case CommentAction.Like:
        apiClient.likeComment(comment).subscribe();
        break;
      case CommentAction.Dislike:
        apiClient.dislikeComment(comment).subscribe();
        break;
      case CommentAction.Delete:
        apiClient.deleteComment(comment).subscribe();
        break;
    }
  }

  handleHideModal() {
    this.setState({showModal: false});
  }

  createComment(content: string) {
    const {apiClient} = this.props;
    const {threadId, parentId} = this.state;
    apiClient.createComment(content, parentId, threadId)
      .subscribe(
        () => this.setState({showModal: false}),
        error => this.setState({errors: error})
      );
  }

  updateComment(newContent: string, comment: Comment) {
    const {apiClient} = this.props;
    apiClient.updateComment(comment, newContent)
      .subscribe(
        () => this.setState({showModal: false, editedComment: null}),
        error => this.setState({errors: error})
      );
  }


  render() {
    const {errors, showModal, editedComment} = this.state;
    const {currentUser, comments} = this.props;
    const commentItems = comments.map(comment => <CommentComponent currentUser={currentUser}
                                                                   comment={comment}
                                                                   dispatchAction={this.handleCommentAction}
                                                                   key={comment.id}/>);

    return (
      <React.Fragment>
        <div className='comments-list'>
          {commentItems}
        </div>
        <ModalComponent show={showModal}
                        onHide={this.handleHideModal}
                        title={!!editedComment ? 'Edit comment' : 'Add comment'}>
          <CommentFormComponent errors={errors}
                                comment={editedComment}
                                onSubmit={editedComment ? this.updateComment : this.createComment}
                                onCancel={this.handleHideModal}/>
        </ModalComponent>
      </React.Fragment>
    );
  }
}