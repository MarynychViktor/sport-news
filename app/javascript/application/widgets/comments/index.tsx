import React from 'react'

import { User } from "./model/user";
import { CommentsApi, CommentsQuery } from "./api/comments-api";
import { CommentInputComponent } from "./components/comment-input-component";
import { CommentList } from "./components/comment-list";
import { Subscription } from "rxjs";

interface CommentsProps {
  currentUser?: User;
  apiClient: CommentsApi
}


export class CommentsComponent extends React.Component<CommentsProps, any & {query: CommentsQuery}> {
  private subscription: Subscription;

  constructor(props) {
    super(props);
    this.state = {
      comments: [],
      query: {page: 1, order: 'popular'},
      hasMoreComments: false,
      total: 0,
    };

    this.listComments = this.listComments.bind(this);
    this.onCreateComment = this.onCreateComment.bind(this);
  }

  componentDidMount() {
    const {apiClient} = this.props;
    this.subscription = apiClient.stream$.subscribe((comments) => this.setState({comments}));
    this.listComments();
  }

  componentWillUnmount() {
    this.subscription.unsubscribe();
  }

  onCreateComment(content: string) {
    const {apiClient} = this.props;
    apiClient.createComment(content).subscribe(() => {

    });
  }

  listComments() {
    const {query} = this.state;
    const {apiClient} = this.props;

    apiClient.listComments(query)
      .subscribe(({last_page, total}) => {
        this.setState({total, hasMoreComments: !last_page, query});
        if (!last_page) {
          query.page++;
        }
      });
  }

  render() {
    const {comments, total, hasMoreComments} = this.state;
    const {currentUser, apiClient} = this.props;

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
            <CommentInputComponent initialValue='' onSubmit={this.onCreateComment}/>
            <CommentList currentUser={currentUser} comments={comments} apiClient={apiClient}/>
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
          </div>
        </div>
      </div>
    );
  }
}