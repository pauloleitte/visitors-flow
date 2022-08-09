import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CeremonyService } from './ceremony.service';
import { CreateCeremonyDTO } from './dto/create-ceremony.dto';
import { UpdateCeremonyDTO } from './dto/update-ceremony.dto';

@Controller('ceremonys')
@UseGuards(JwtAuthGuard)
export class CeremonyController {
  constructor(private service: CeremonyService) {}

  @Get()
  getAll() {
    return this.service.getAll();
  }

  @Post()
  create(@Body() ceremony: CreateCeremonyDTO) {
    return this.service.create(ceremony);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.service.getById(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() ceremony: UpdateCeremonyDTO) {
    return this.service.findByIdAndUpdate(id, ceremony);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.service.delete(id);
  }
}
