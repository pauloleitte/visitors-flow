import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type MemberDocument = Member & Document;

const schemaOptions = {
  timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' },
};
@Schema(schemaOptions)
export class Member {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  phone: string;

  @Prop()
  email: string;

  @Prop()
  instagram: string;

  @Prop({ required: true })
  address: string;

  @Prop({ required: true })
  job: string;

  @Prop({required: true})
  birthday: Date;

  @Prop({required: true})
  genre: string;
}

export const MemberSchema = SchemaFactory.createForClass(Member);
