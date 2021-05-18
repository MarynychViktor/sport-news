import { User } from "./user";

export class Comment {
  id: number;
  content: string;
  edited: boolean;
  parent?: Comment;
  thread?: Comment;
  user: User;
  feedbacks: [];
  children?: Comment[];
}
