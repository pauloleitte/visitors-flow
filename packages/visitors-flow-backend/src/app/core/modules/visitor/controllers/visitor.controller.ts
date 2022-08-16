import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  UseGuards,
  Delete,
  Query,
} from '@nestjs/common';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { CreateVisitorDTO } from '../dto/create-visitor.dto';
import { UpdateVisitorDTO } from '../dto/update-visitor.dto';
import { VisitorRepository } from '../repositories/visitor.repository';

@Controller('visitors')
@UseGuards(JwtAuthGuard)
export class VisitorController {
  constructor(private visitorRepository: VisitorRepository) {}

  @Get()
  async getAll(@Query() { take, skip, name }) {
    return this.visitorRepository.getAll({take, skip, name});
  }
  @Post()
  async create(@Body() visitor: CreateVisitorDTO) {
    return this.visitorRepository.create(visitor);
  }

  @Patch('/:id')
  async update(@Param('id') id: string, @Body() visitor: UpdateVisitorDTO) {
    return this.visitorRepository.findByIdAndUpdate(id, visitor);
  }

  @Delete('/:id')
  async delete(@Param('id') id: string) {
    return this.visitorRepository.delete(id);
  }
}
