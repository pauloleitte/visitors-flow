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
import { CreateNoticeDTO } from '../dto/create-notice.dto';
import { UpdateNoticeDTO } from '../dto/update-notice.dto';
import { NoticeService } from '../services/notice.service';

@Controller('notices')
@UseGuards(JwtAuthGuard)
export class NoticeController {
  constructor(private service: NoticeService) {}

  @Get()
  async getAll(@Query() { take, skip, name }) {
    return this.service.getAll(take, skip, name);
  }
  @Post()
  async create(@Body() notice: CreateNoticeDTO) {
    return this.service.create(notice);
  }

  @Patch('/:id')
  async update(@Param('id') id: string, @Body() notice: UpdateNoticeDTO) {
    return this.service.findByIdAndUpdate(id, notice);
  }

  @Delete('/:id')
  async delete(@Param('id') id: string) {
    return this.service.findByIdAndDelete(id);
  }
}
