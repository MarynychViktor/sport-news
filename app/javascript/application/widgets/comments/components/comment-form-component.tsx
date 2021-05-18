import React from "react";

import { Comment } from "../model/comment";

type CommentReplyProps = {comment?: Comment, errors?: any, onSubmit: (content: string, comment?: Comment) => any, onCancel: () => any};

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
    const {comment, onSubmit} = this.props;
    event.preventDefault();
    onSubmit(this.state.content, comment);
  }

  handleContentChange(event) {
    this.setState({content: event.target.value, errors: null})
  }

  render() {
    const {errors} = this.state;
    const {comment, onCancel} = this.props;

    return (
        <form onSubmit={this.handleSubmit}>
          <div className={`${errors && 'field_with_errors'}`}>
                <textarea className={`app-input comment-dialog-input`} rows={10} aria-invalid={errors ? 'true' : 'false'}
                          onInput={this.handleContentChange} defaultValue={comment && comment.content || ''}/>
            {errors && <div className='app-input-error'>{ errors.content[0] }</div>}
          </div>

          <div className="app-modal-actions">
            <button type='button' className="button-plain" onClick={onCancel}>Cancel</button>
            <button type='submit'  className="button">Submit</button>
          </div>
        </form>
    );
  }
}