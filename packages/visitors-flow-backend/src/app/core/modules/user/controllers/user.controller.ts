import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { Roles } from '../../auth/decorators/role.decorator';
import { Role } from '../../auth/enums/role.enum';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { RoleGuard } from '../../auth/guards/role.guard';
import { CreateUserDto } from '../dto/create-user.dto';
import { UpdateUserDto } from '../dto/update-user.dto';
import { UserService } from '../services/user.service';

@Controller('users')
export class UserController {
  constructor(private readonly service: UserService) {}

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.service.create(createUserDto);
  }

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Get()
  findAll() {
    return this.service.getAll();
  }

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.service.getById(id);
  }
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.service.findByIdAndUpdate(id, updateUserDto);
  }

  @Roles(Role.Admin)
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.service.delete(id);
  }
}
