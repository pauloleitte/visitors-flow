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
import { CreateMemberDTO } from '../dto/create-member.dto';
import { UpdateMemberDTO } from '../dto/update-member.dto';
import { MemberService } from '../services/member.service';

@Controller('members')
@UseGuards(JwtAuthGuard)
export class MemberController {
  constructor(private service: MemberService) {}

  @Get()
  async getAll(@Query() { take, skip, name }) {
    return this.service.getAll(take, skip, name);
  }

  @Get('birthday-of-month')
  async getBirthdayOfWeek(){
    return this.service.getBirthdayOfMonth();
  }

  @Post()
  async create(@Body() member: CreateMemberDTO) {
    return this.service.create(member);
  }

  @Patch('/:id')
  async update(@Param('id') id: string, @Body() member: UpdateMemberDTO) {
    return this.service.findByIdAndUpdate(id, member);
  }

  @Delete('/:id')
  async delete(@Param('id') id: string) {
    return this.service.findByIdAndDelete(id);
  }
}
