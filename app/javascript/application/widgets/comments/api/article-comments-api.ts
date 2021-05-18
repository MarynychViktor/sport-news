import { Observable } from "rxjs";

import { Commentable } from "../model/commentable";
import { CommentsApi, PaginatedResponse } from "./comments-api";
import { Comment } from "../model/comment";
import { tap } from "rxjs/operators";

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
    ).pipe(
      tap(({data}) => {
        const previous = query.page === 1 ? [] : this.source.value;
        this.source.next([...previous, ...data]);
      }));
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
    ).pipe(
      tap((comment) => {
        this.replaceSteamComment(comment)
      })
    )
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
    ).pipe(
      tap((comment) => this.addCommentToStream(comment))
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
    ).pipe(
      tap((comment) => this.replaceSteamComment(comment))
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
    ).pipe(
      tap((comment) => this.replaceSteamComment(comment))
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
    ).pipe(
      tap(() => this.deleteCommentFromStream(comment))
    );
  }
}