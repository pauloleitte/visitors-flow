import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { VisitorSchema } from './schema/visitor.schema';
import { VisitorController } from './visitor.controller';
import { VisitorService } from './visitor.service';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Visitor', schema: VisitorSchema }]),
  ],
  controllers: [VisitorController],
  providers: [VisitorService],
  exports: []
})
export class VisitorModule { }
