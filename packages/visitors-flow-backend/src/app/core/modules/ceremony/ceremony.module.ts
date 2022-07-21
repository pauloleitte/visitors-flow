import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { CeremonyController } from './ceremony.controller';
import { CeremonyService } from './ceremony.service';
import { CeremonySchema } from './schema/ceremony.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Ceremony', schema: CeremonySchema }]),
  ],
  controllers: [CeremonyController],
  providers: [CeremonyService],
  exports: []
})
export class CeremonyModule { }
