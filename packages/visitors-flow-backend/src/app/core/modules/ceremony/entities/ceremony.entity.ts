import { Entity, Column, ObjectIdColumn } from 'typeorm';

@Entity()
export class Ceremony {
  @ObjectIdColumn()
  _id: string;
  @Column()
  name: string;

  @Column()
  description: string;

  @Column({ default: new Date() })
  date: Date;
}
