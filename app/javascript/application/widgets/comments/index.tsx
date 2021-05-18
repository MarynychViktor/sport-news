import React from 'react'

import { User } from "./model/user";
import { CommentsApi } from "./api/comments-api";
import { CommentInputComponent } from "./components/comment-input-component";
import { CommentFormComponent } from "./components/comment-form-component";
import { Comment as CommentComponent } from "./components/comment";
import { Comment } from "./model/comment";
import { ModalComponent } from "./components/modal-component";

interface CommentsProps {
  currentUser?: User;
  apiClient: CommentsApi
}

export class CommentsComponent extends React.Component<CommentsProps, any> {
  constructor(props) {
    super(props);
    this.state = {
      comments: [],
      query: {page: 1},
      hasMoreComments: false,
      total: 0,
      threadId: null,
      parentId: null,
      errors: null,
      showModal: false,
      editedComment: null
    };

    this.updateComment = this.updateComment.bind(this);
    this.createComment = this.createComment.bind(this);
    this.handleListComments = this.handleListComments.bind(this);
    this.onCreate = this.onCreate.bind(this);
    this.onEdit = this.onEdit.bind(this);
    this.handleHideModal = this.handleHideModal.bind(this);
    this.likeComment = this.likeComment.bind(this);
    this.dislikeComment = this.dislikeComment.bind(this);
  }

  componentDidMount() {
    this.handleListComments();
  }

  handleHideModal() {
    this.setState({showModal: false});
  }

  handleListComments() {
    const {query, comments} = this.state;
    const {apiClient} = this.props;

    apiClient.listComments(query)
      .subscribe(({last_page, data, total}) => {
        if (!last_page) {
          query.page++;
        }

        comments.push(...data);
        this.setState({comments, total, hasMoreComments: !last_page, query});
      });
  }

  createComment(content: string) {
    const {apiClient} = this.props;
    const {threadId, parentId, comments} = this.state;

    apiClient.createComment(content, parentId, threadId)
      .subscribe(
        newComment => {
          const thread = comments.find(comment => comment.id == newComment.thread_id);

          if (thread) {
            thread.children.push(newComment);
          } else {
            comments.push(newComment);
          }

          this.setState({comments, errors: null, showModal: false});
        },
        (response) => this.setState({errors: response}));
  }

  updateComment(newContent: string, comment: Comment) {
    const {apiClient} = this.props;
    const {comments} = this.state;

    apiClient.updateComment(comment, newContent)
      .subscribe(updatedComment => {
          if (updatedComment.thread_id) {
            const thread = comments.find(comment => comment.id == updatedComment.thread_id);
            const index = thread.findIndex(comment => comment.id == updatedComment.id);
            thread[index] = updatedComment
          } else {
            const index = comments.findIndex(comment => comment.id == updatedComment.id);
            comments[index] = updatedComment
          }

          this.setState({comments, errors: null, showModal: false});
        },
        (response) => this.setState({errors: response}));
  }

  onCreate(comment: Comment) {
    const threadId = comment.thread_id || comment.id;
    const parentId = comment.id;
    this.setState({threadId, parentId, showModal: true, editedComment: null});
  }

  onEdit(comment: Comment) {
    this.setState({editedComment: comment});
    this.setState({showModal: true});
  }

  likeComment(comment: Comment) {
    const {apiClient} = this.props;
    const {comments} = this.state;

    apiClient.likeComment(comment).subscribe(updatedComment => {
        if (updatedComment.thread_id) {
          const thread = comments.find(comment => comment.id == updatedComment.thread_id);
          console.log('thread', thread, {...comments}, 'comments');
          const index = thread.children.findIndex(comment => comment.id == updatedComment.id);
          thread.children[index] = updatedComment
        } else {
          const index = comments.findIndex(comment => comment.id == updatedComment.id);
          comments[index] = updatedComment
        }

        this.setState({comments, errors: null, showModal: false});
      },
      (response) => this.setState({errors: response}));
  }

  dislikeComment(comment: Comment) {
    const {apiClient} = this.props;
    const {comments} = this.state;

    apiClient.dislikeComment(comment).subscribe(updatedComment => {
        if (updatedComment.thread_id) {
          const thread = comments.find(comment => comment.id == updatedComment.thread_id);
          const index = thread.children.findIndex(comment => comment.id == updatedComment.id);
          thread.children[index] = updatedComment
        } else {
          const index = comments.findIndex(comment => comment.id == updatedComment.id);
          comments[index] = updatedComment
        }

        this.setState({comments, errors: null, showModal: false});
      },
      (response) => this.setState({errors: response}));
  }

  render() {
    const {comments, total, errors, showModal, editedComment, hasMoreComments} = this.state;
    const {currentUser} = this.props;

    const commentElements = comments.map(
      comment => <CommentComponent currentUser={currentUser}
                                   comment={comment}
                                   onEdit={this.onEdit}
                                   likeComment={this.likeComment}
                                   dislikeComment={this.dislikeComment}
                                   onCreate={this.onCreate} key={comment.id}/>
    );

    return (
      <div className='comments'>
        <div className='comments-container'>
          <div className="comments-header">
            <div className="comments-title">
              Comments ({total})
            </div>
            <div className="comments-sort">
              <button id="comments-order" className="button-plain" aria-expanded="false" aria-haspopup="true"
                      data-toggle="dropdown" type="button">
                Most popular
              </button>
              <div className="dropdown-menu" aria-labelledby="comments-order">
                <a href="#" className="dropdown-item">Most popular</a>
                <a href="#" className="dropdown-item">Oldest first</a>
                <a href="" className="dropdown-item">Newest first</a>
              </div>
            </div>
          </div>

          <div className="comments-content">
            <CommentInputComponent initialValue='' onSubmit={this.createComment}/>
            <div className='comments-list'>
              {commentElements}
            </div>
            {/*TODO: add pagination with show more button*/}
            {
              hasMoreComments && (
                <div className="comments-toggle-container">
                  <a href="#" className='comments-toggle comment-button'>
                    Show more
                    <div className="comments-toggle-icon show-less material-icons-outlined">
                      keyboard_arrow_down
                    </div>
                  </a>
                </div>
              )
            }

            {/*= link_to '#', class: 'comments-toggle comment-button' do*/}
            {/*.comments-toggle-icon.show-less.material-icons-outlined*/}
            {/*| keyboard_arrow_up*/}
            {/*| Show less*/}

            {/*= link_to '#', class: 'comments-toggle comment-button' do*/}
            {/*| Show more*/}
            {/*.comments-toggle-icon.material-icons-outlined*/}
            {/*| keyboard_arrow_down*/}
          </div>
        </div>
          <ModalComponent show={showModal} onHide={this.handleHideModal} title={!!editedComment ? 'Edit comment' : 'Add comment'}>
            <CommentFormComponent errors={errors} comment={editedComment} onSubmit={editedComment ? this.updateComment : this.createComment}
                                  onCancel={this.handleHideModal}/>
          </ModalComponent>
      </div>
    );
  }
}