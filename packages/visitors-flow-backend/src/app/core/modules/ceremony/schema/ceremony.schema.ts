import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose, { Document } from 'mongoose';
import { Visitor } from '../../visitor/schema/visitor.schema';

export type CeremonyDocument = Ceremony & Document;

const schemaOptions = {
  timestamps: { createdAt: 'created_at', updatedAt: 'updated_at' },
};
@Schema(schemaOptions)
export class Ceremony {
  @Prop()
  name: string;

  @Prop()
  description: string;

  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: Visitor.name }],
    required: false,
  })
  
  @Prop({ default: new Date() })
  date: Date;
}

export const CeremonySchema = SchemaFactory.createForClass(Ceremony);
