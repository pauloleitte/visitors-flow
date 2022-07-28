import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  UseGuards,
  Delete,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CreateVisitorDTO } from './dto/create-visitor.dto';
import { UpdateVisitorDTO } from './dto/update-visitor.dto';
import { VisitorService } from './visitor.service';

@Controller('visitors')
@UseGuards(JwtAuthGuard)
export class VisitorController {
  constructor(private visitorService: VisitorService) {}

  @Get()
  async getAll() {
    return this.visitorService.getAll();
  }

  @Post()
  async create(@Body() visitor: CreateVisitorDTO) {
    return this.visitorService.create(visitor);
  }

  @Patch('/:id')
  async update(@Param('id') id: string, @Body() visitor: UpdateVisitorDTO) {
    return this.visitorService.findByIdAndUpdate(id, visitor);
  }

  @Delete('/:id')
  async delete(@Param('id') id: string) {
    return this.visitorService.findByIdAndDelete(id);
  }
}
