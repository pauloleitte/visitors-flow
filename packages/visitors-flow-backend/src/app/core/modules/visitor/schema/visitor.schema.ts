import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose, { Document } from 'mongoose';
import { Ceremony } from '../../ceremony/schema/ceremony.schema';

export type UserDocument = Visitor & Document;

const schemaOptions = {
  timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' },
};
@Schema(schemaOptions)
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
  church: string;

  @Prop({ required: false })
  observations: string;

  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Ceremony" }],
  })
  ceremonies: Ceremony;
}

export const VisitorSchema = SchemaFactory.createForClass(Visitor);
