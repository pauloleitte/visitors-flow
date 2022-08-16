import { Module } from '@nestjs/common';
import { VisitorController } from './controllers/visitor.controller';
import { Visitor } from './entities/visitor.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VisitorRepository } from './repositories/visitor.repository';

@Module({
  imports: [
    TypeOrmModule.forFeature([Visitor]),
  ],
  controllers: [VisitorController],
  providers: [VisitorRepository],
  exports: []
})
export class VisitorModule { }
