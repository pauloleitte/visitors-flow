import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose, { Document } from 'mongoose';
import { Visitor } from '../../visitor/schema/visitor.schema';
import { Type } from 'class-transformer';

export type CeremonyDocument = Ceremony & Document;

@Schema()
export class Ceremony {
  @Prop()
  name: string;

  @Prop()
  description: string;

  @Prop()
  date: string;

  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: Visitor.name }],
    required: false,
  })
  @Type(() => Visitor)
  visitors: Visitor;
}

export const CeremonySchema = SchemaFactory.createForClass(Ceremony);
