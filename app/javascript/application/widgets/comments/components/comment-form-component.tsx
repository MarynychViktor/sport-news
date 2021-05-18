import React from "react";
import { Comment } from "../model/comment";

type CommentReplyProps = {comment?: Comment, parent: Comment, thread: Comment, errors?: any,
  onReply: (content: string, comment?: Comment) => any};

export class CommentFormComponent extends React.Component<CommentReplyProps, any> {
  constructor(props) {
    super(props);
    this.state = {content: '', errors: null};
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleContentChange = this.handleContentChange.bind(this);
  }

  componentDidMount() {
    const {errors} = this.props;
    this.setState({errors: errors});
  }

  componentDidUpdate(prevProps: Readonly<CommentReplyProps>, prevState: Readonly<any>, snapshot?: any) {
    if (prevProps.errors !== this.props.errors) {
      this.setState({errors: this.props.errors});
    }
  }

  handleSubmit(event) {
    const {comment} = this.props;
    event.preventDefault();
    this.props.onReply(this.state.content, comment);
  }

  handleContentChange(event) {
    this.setState({content: event.target.value, errors: null})
  }

  render() {
    const {errors} = this.state;
    const {comment} = this.props;

    return (
      <form onSubmit={this.handleSubmit}>
        <div className={`${errors && 'field_with_errors'}`}>
          <textarea className={`app-input comment-dialog-input`} rows={10} aria-invalid={errors ? 'true' : 'false'}
                    onInput={this.handleContentChange} defaultValue={comment && comment.content || ''}/>
          {errors && <div className='app-input-error'>{ errors.content[0] }</div>}
        </div>

        <div className="app-modal-actions">
          <button className="button-plain" data-dismiss="modal" type="button">Cancel</button>
          <button className="button">Add</button>
        </div>
      </form>
    );
  }
}