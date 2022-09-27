import { DepartamentService } from './../services/departament.service';
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
import { FilterParams } from '../../../../shared/utils/filter-params';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { CreateDepartamentDTO } from '../dto/create-departament.dto';
import { UpdateDepartamentDTO } from '../dto/update-departament.dto';


@Controller('departaments')
@UseGuards(JwtAuthGuard)
export class DepartamentController {
  constructor(private service: DepartamentService) {}

  @Get()
  async getAll(@Query() { take, skip, name }: FilterParams) {
    return this.service.getAll(take, skip, name);
  }

  @Post()
  create(@Body() departament: CreateDepartamentDTO) {
    return this.service.create(departament);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.service.getById(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() departament: UpdateDepartamentDTO) {
    return this.service.findByIdAndUpdate(id, departament);
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.service.delete(id);
  }
}
