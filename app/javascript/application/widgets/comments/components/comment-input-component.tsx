import { User } from "../model/user";
import React, { createRef, RefObject } from "react";

type CommentFormProps = {initialValue: string, onSubmit: (content: string) => any, user?: User}

export class CommentInputComponent extends React.Component<CommentFormProps, { content: string }>{
  private readonly input: RefObject<HTMLDivElement>;

  constructor(props) {
    super(props);
    this.state = {content: ''}
    this.input = createRef();
    this.handleInput = this.handleInput.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleCancel = this.handleCancel.bind(this);
  }

  componentDidMount() {
    const {initialValue} = this.props;
    this.setState({content: initialValue});
    this.input.current.innerHTML = initialValue;
  }

  handleInput(e) {
    e.preventDefault();
    this.setState({content: e.target.innerText});
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.onSubmit(this.state.content);
    this.input.current.innerHTML = '';
    this.setState({content: ''});
  }

  handleCancel(e) {
    e.preventDefault();
    this.input.current.innerHTML = '';
    this.setState({content: ''});
  }

  render() {
    const {content} = this.state;

    return (
      <div className="comments-form">
        <div className="comment-user">
          <div className="comment-user-avatar-wrapper">
            <img src="https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png" alt=""/>
          </div>
        </div>
        <div className="comments-input-wrapper">
          <div className="comments-input" id="comment-input" contentEditable="true" placeholder="Write a comment"
               ref={this.input} onInput={this.handleInput}>
          </div>
          {content.trim() && (
            <div className="comments-input-actions comment-meta-actions">
              <a href="#" onClick={this.handleCancel} className='comment-meta-action comment-button comments-form-cancel'>
                Cancel
              </a>
              <a href="#" onClick={this.handleSubmit} className='comment-meta-action comment-button comments-form-cancel'>
                Submit
              </a>
            </div>
          )}
        </div>
      </div>
    );
  }
}
