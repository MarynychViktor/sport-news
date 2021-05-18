import { Observable } from "rxjs";

import { Comment } from "../model/comment";

export type plainParam = number|string;

export interface PaginatedResponse<T = any> {
  data: T[],
  page: number,
  total: number,
  last_page: boolean
}

export abstract class CommentsApi {
  private csrfToken: string;

  abstract listComments(query: {page: number}): Observable<PaginatedResponse<Comment>>;
  abstract updateComment(comment: Comment, content: string): Observable<any>;
  abstract createComment(content: string, parentId?: plainParam, threadId?: plainParam): Observable<any> ;

  getCsrfToken() {
    if (!this.csrfToken) {
      this.csrfToken = (document.querySelector("[name='csrf-token']") as any).content;
    }

    return this.csrfToken;
  }
}
