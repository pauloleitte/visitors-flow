import { Entity, Column, ObjectIdColumn } from 'typeorm';

@Entity()
export class Visitor {

  @ObjectIdColumn()
  _id: string;

  @Column()
  name: string;

  @Column()
  email: string;

  @Column()
  telephone: string;

  @Column()
  isChurchgoer: boolean;

  @Column()
  church: string;

  @Column()
  observations: string;
}
