import { DepartamentService } from './services/departament.service';
import { DepartamentController } from './controllers/departament.controller';
import { DepartamentSchema } from './schema/departament.schema';
import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: 'Departament', schema: DepartamentSchema },
    ]),
  ],
  controllers: [DepartamentController],
  providers: [DepartamentService],
  exports: [],
})
export class DepartamentModule {}
