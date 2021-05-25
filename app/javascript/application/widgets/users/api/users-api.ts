import { Observable } from "rxjs";
import { User } from "../model/user";

export class UsersApi {
  private csrfToken: string;

  listUsers({page, limit, role}: {page: number, limit: number, role: 'admin'|'user'}) {
    return this.wrapIntoObservable(
      fetch(`/cms/users?page=${page}&role=${role}&limit=${limit}`, {
        method: 'GET',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  activate(user: User) {
    return this.wrapIntoObservable(
      fetch(`/cms/users/${user.id}/activate`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  block(user: User) {
    return this.wrapIntoObservable(
      fetch(`/cms/users/${user.id}/block`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  makeAdmin(user: User) {
    return this.wrapIntoObservable(
      fetch(`/cms/users/${user.id}/add-admin`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  removeAdmin(user: User) {
    return this.wrapIntoObservable(
      fetch(`/cms/users/${user.id}/remove-admin`, {
        method: 'POST',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  delete(user: User) {
    return this.wrapIntoObservable(
      fetch(`/cms/users/${user.id}`, {
        method: 'DELETE',
        headers: {
          "X-CSRF-Token": this.getCsrfToken(),
        },
      })
    );
  }

  protected wrapIntoObservable<T = any>(fetchRequest: Promise<any>): Observable<T> {
    return new Observable(observer => {
      fetchRequest
        .then((response: any) => {
          const contentType = response.headers.get("content-type");

          if (contentType && contentType.indexOf("application/json") !== -1) {
            return response.json().then(result => {
              if (response.status >= 400) {
                return Promise.reject(result);
              }

              return Promise.resolve(result);
            })
          } else {
            return response.text().then(text => {
              if (response.status >= 400) {
                return Promise.reject(text);
              }

              return Promise.resolve(text);
            });
          }
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

  private getCsrfToken() {
    if (!this.csrfToken) {
      this.csrfToken = (document.querySelector("[name='csrf-token']") as any).content;
    }

    return this.csrfToken;
  }
}