import { User } from "./user";

export class Comment {
  id: number;
  content: string;
  edited: boolean;
  parent_id?: Comment;
  thread_id?: Comment;
  user: User;
  feedbacks: [];
  children?: Comment[];
  likes: number;
  dislikes: number;
  liked_by_current_user?: boolean;
  disliked_by_current_user?: boolean;
}
