import { Observable } from "rxjs";

import { Commentable } from "../model/commentable";
import { CommentsApi, PaginatedResponse } from "./comments-api";
import { Comment } from "../model/comment";

export class ArticleCommentsApi extends CommentsApi {
  constructor(private resource: Commentable) {
    super();
  }

  listComments(query: { page: number }): Observable<PaginatedResponse<Comment>> {
    return this.wrapIntoObservable(
      fetch(`/articles/${this.resource.id}/comments`, {
        method: 'GET',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  updateComment(comment: Comment, content: string): Observable<any> {
    return this.wrapIntoObservable(
      fetch(`/articles/${this.resource.id}/comments/${comment.id}`, {
        method: 'PATCH',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({comment: {content}}),
      })
    );
  }

  createComment(content: string, parentId = '', threadId = ''): Observable<any> {
    return this.wrapIntoObservable(
      fetch(`/articles/${this.resource.id}/comments`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({comment: {content, parent_id: parentId, thread_id: threadId}}),
      })
    );
  }

  likeComment(comment: Comment): Observable<Comment> {
    return this.wrapIntoObservable(
      fetch(`/articles/${this.resource.id}/comments/${comment.id}/like`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
          'Content-Type': 'application/json'
        },
      })
    );
  }

  dislikeComment(comment: Comment): Observable<Comment> {
    return this.wrapIntoObservable(
      fetch(`/articles/${this.resource.id}/comments/${comment.id}/dislike`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
          'Content-Type': 'application/json'
        },
      })
    );
  }

  deleteComment(comment: Comment): Observable<void> {
    return this.wrapIntoObservable(
      fetch(`/articles/${this.resource.id}/comments/${comment.id}`, {
        method: 'DELETE',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
          'Content-Type': 'application/json'
        },
      })
    );
  }

  private wrapIntoObservable<T>(fetchRequest: Promise<any>): Observable<T> {
    return new Observable(observer => {
      fetchRequest
        .then((response: any) => {
          return response.json().then(result => {
              if (response.status >= 400) {
                return Promise.reject(result);
              }

              return Promise.resolve(result);
            })
        })
        .then(result => {
          observer.next(result);
          observer.complete();
        })
        .catch(error => {
          observer.error(error)
        });
    })
  }
}