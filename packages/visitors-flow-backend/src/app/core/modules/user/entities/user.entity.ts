import { Entity, Column, ObjectIdColumn } from 'typeorm';

@Entity()
export class User {
  @ObjectIdColumn()
  _id: string;
  @Column()
  name: string;
  @Column()
  password: string;

  @Column()
  email: string;
  @Column()
  phone: string;
}
