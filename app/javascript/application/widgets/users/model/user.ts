export interface User {
  id: number;
  first_name: string;
  last_name: string;
  photo: {url: string};
  blocked: boolean;
  admin: boolean;
}