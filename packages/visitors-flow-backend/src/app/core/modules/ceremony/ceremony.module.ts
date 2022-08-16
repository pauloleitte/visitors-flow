import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { CeremonyController } from './controllers/ceremony.controller';
import { CeremonySchema } from './schema/ceremony.schema';
import { CeremonyService } from './services/ceremony.service';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Ceremony', schema: CeremonySchema }]),
  ],
  controllers: [CeremonyController],
  providers: [CeremonyService],
  exports: [],
})
export class CeremonyModule {}
