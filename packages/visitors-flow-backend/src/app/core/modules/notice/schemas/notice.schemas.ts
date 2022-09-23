import { Ceremony } from './../../ceremony/schema/ceremony.schema';
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose, { Document } from 'mongoose';

export type NoticeDocument = Notice & Document;

const schemaOptions = {
  timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' },
};
@Schema(schemaOptions)
export class Notice {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  description: string;

  @Prop()
  isDone: boolean;

  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Ceremony" }],
  })
  ceremonies: Ceremony;
}

export const NoticeSchema = SchemaFactory.createForClass(Notice);
