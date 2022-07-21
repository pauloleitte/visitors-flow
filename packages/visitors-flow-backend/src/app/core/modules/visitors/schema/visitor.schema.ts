import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type UserDocument = Visitor & Document;

@Schema()
export class Visitor {
  @Prop()
  name: string;

  @Prop({ required: false })
  email: string;

  @Prop({ required: false })
  telephone: string;

  @Prop({ required: false })
  isChurchgoer: boolean;

  @Prop({ required: false })
  churh: string;

  @Prop({ required: false })
  observations: string;
}

export const VisitorSchema = SchemaFactory.createForClass(Visitor);
