import { User } from "./user";

export class Comment {
  id: number;
  content: string;
  edited: boolean;
  parent_id?: number;
  thread_id?: number;
  user: User;
  feedbacks: [];
  children?: Comment[];
  likes: number;
  dislikes: number;
  liked_by_current_user?: boolean;
  disliked_by_current_user?: boolean;
}
