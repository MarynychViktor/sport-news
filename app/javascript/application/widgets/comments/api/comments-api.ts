import { BehaviorSubject, Observable } from "rxjs";

import { Comment } from "../model/comment";

export type plainParam = number|string;

export interface PaginatedResponse<T = any> {
  data: T[],
  page: number,
  total: number,
  last_page: boolean
}


export interface CommentsQuery {
  page: number,
  limit?: number,
  order: 'newest' | 'oldest' | 'popular'
}

export abstract class StreamableApi {
  protected source = new BehaviorSubject<Comment[]>([]);
  public stream$ = this.source.asObservable();

  protected replaceSteamComment(comment: Comment) {
    if (comment.thread_id) {
      this.replaceThreadComment(comment);
    } else {
      this.replaceRootComment(comment);
    }
  }

  protected replaceThreadComment(comment: Comment) {
    const comments = [...this.source.value];
    const threadIndex = comments.findIndex(c => c.id === comment.thread_id);
    const commentIndex = comments[threadIndex].children.findIndex(c => c.id == comment.id);
    comments[threadIndex].children[commentIndex] = comment;
    this.source.next(comments);
  }

  protected replaceRootComment(comment: Comment) {
    const comments = [...this.source.value];
    const index = comments.findIndex(c => c.id == comment.id);
    comments[index] = comment;
    this.source.next(comments);
  }

  protected addCommentToStream(comment: Comment) {
    const comments = [...this.source.value];

    if (comment.thread_id) {
      const threadIndex = comments.findIndex(c => c.id === comment.thread_id);
      comments[threadIndex].children.push(comment);
    } else {
      comments.unshift(comment);
    }

    this.source.next(comments);
  }

  protected deleteCommentFromStream(comment: Comment) {
    const comments = [...this.source.value];

    if (comment.thread_id) {
      const threadIndex = comments.findIndex(c => c.id === comment.thread_id);
      const commentIndex = comments[threadIndex].children.findIndex(c => c.id == comment.id);
      comments[threadIndex].children.splice(commentIndex, 1);
    } else {
      const commentIndex = comments.findIndex(c => c.id == comment.id);
      comments.splice(commentIndex, 1);
    }

    this.source.next(comments);
  }

  protected wrapIntoObservable<T = any>(fetchRequest: Promise<any>): Observable<T> {
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

export abstract class CommentsApi extends StreamableApi {
  private csrfToken: string;

  abstract listComments(query: {page: number}): Observable<PaginatedResponse<Comment>>;
  abstract updateComment(comment: Comment, content: string): Observable<Comment>;
  abstract createComment(content: string, parentId?: plainParam, threadId?: plainParam): Observable<Comment> ;
  abstract likeComment(comment: Comment): Observable<Comment>;
  abstract dislikeComment(comment: Comment): Observable<Comment>;
  abstract deleteComment(comment: Comment): Observable<void>;

  getCsrfToken() {
    if (!this.csrfToken) {
      this.csrfToken = (document.querySelector("[name='csrf-token']") as any).content;
    }

    return this.csrfToken;
  }
}
