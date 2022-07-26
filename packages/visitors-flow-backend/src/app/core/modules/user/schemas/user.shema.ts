import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type UserDocument = User & Document;

@Schema()
export class User {
  @Prop()
  name: string;

  @Prop()
  email: string;

  @Prop()
  password: string;

  @Prop()
  phone: string;

  @Prop({ required: false })
  passwordResetToken: string;

  @Prop({ required: false })
  passwordResetExpires: string;
}

export const UserSchema = SchemaFactory.createForClass(User);
