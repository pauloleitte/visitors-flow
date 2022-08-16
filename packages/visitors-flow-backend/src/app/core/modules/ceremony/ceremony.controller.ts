import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { FilterParams } from '../../../shared/utils/filter-params';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CeremonyService } from './ceremony.service';
import { CeremonyOfDayDTO } from './dto/ceremony-of-day.dto';
import { CreateCeremonyDTO } from './dto/create-ceremony.dto';
import { UpdateCeremonyDTO } from './dto/update-ceremony.dto';

@Controller('ceremonys')
@UseGuards(JwtAuthGuard)
export class CeremonyController {
  constructor(private service: CeremonyService) {}

  @Get()
  async getAll(@Query() { page, limit, name }: FilterParams) {
    return this.service.getAll({page, limit, name});
  }

  @Post('of-day')
  async getOfDay(@Body() ceremony: CeremonyOfDayDTO) {
    return this.service.getCeremoniesOfDay(ceremony);
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
