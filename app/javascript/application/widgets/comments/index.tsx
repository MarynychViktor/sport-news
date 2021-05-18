import React from 'react'

import { User } from "./model/user";
import { CommentsApi } from "./api/comments-api";
import { CommentInputComponent } from "./components/comment-input-component";
import { CommentFormComponent } from "./components/comment-form-component";
import { CommentComponent } from "./components/comment-component";
import { Comment } from "./model/comment";

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
      hasMoreComments: true,
      total: 0,
      thread: null,
      parent: null,
      errors: null,
      showModal: false,
      editedComment: null
    };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleListComments = this.handleListComments.bind(this);
    this.openReplyForm = this.openReplyForm.bind(this);
    this.toggleModal = this.toggleModal.bind(this);
    this.onEdit = this.onEdit.bind(this);
  }

  componentDidMount() {
    this.handleListComments();
    $('#commentsModal').on('hidden.bs.modal', () => this.setState({showModal: false}));
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

  handleSubmit(content: string, comment = null) {
    const {apiClient} = this.props;
    const {thread, parent} = this.state;

    (
      comment ?
        apiClient.updateComment(comment, content) :
        apiClient.createComment(content, parent && parent.id, thread && thread.id)
    )
      .subscribe(
        res => {
          this.setState({errors: null});
          this.toggleModal();
        },
        (response) => {
          this.setState({errors: response});
        });
  }

  // TODO: ugly naming fix
  openReplyForm(comment: Comment) {
    const thread = comment.thread || comment;
    const parent = comment;
    this.setState({thread, parent});
    this.toggleModal();
  }

  onEdit(comment: Comment) {
    this.setState({editedComment: comment});
    this.toggleModal();
  }

  toggleModal() {
    const {showModal} = this.state;

    if (showModal) {
      ($('#commentsModal') as any).modal('hide');
    } else {
      ($('#commentsModal') as any).modal('show');
    }

    this.setState({showModal: !showModal});
  }

  render() {
    const {comments, total, thread, parent, errors, showModal, editedComment} = this.state;
    const {currentUser} = this.props;

    const commentElements = comments.map(
      comment => <CommentComponent currentUser={currentUser} comment={comment} onEdit={this.onEdit}
                                   onReply={this.openReplyForm} key={comment.id}/>
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
            <CommentInputComponent initialValue='' onSubmit={this.handleSubmit}/>
            <div className='comments-list'>
              {commentElements}
            </div>
          </div>
        </div>
        <div id="commentsModal" className="modal fade" aria-hidden="true" aria-labelledby="modal" role="dialog" tabIndex={-1}>
          <div className="modal-dialog modal-dialog-centered" role="document">
            <div className="modal-content app-modal-content" id="modal-content">
              <div className='app-modal-title'>Add Comment</div>
              <div className='app-modal-form'>
                {
                  showModal &&
                  <CommentFormComponent errors={errors} parent={parent} thread={thread} comment={editedComment}
                                        onReply={this.handleSubmit}/>
                }
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}