import { InjectModel } from '@nestjs/mongoose';
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import { User } from '../schemas/user.shema';
import { CreateUserDto } from '../dto/create-user.dto';
import { UpdateUserDto } from '../dto/update-user.dto';
import { BcryptService } from '../../../../shared/services/bcrypt.service';
import {
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common/exceptions';

@Injectable()
export class UserService {
  constructor(
    @InjectModel('User') private readonly userModel: Model<User>,
    private bcryptService: BcryptService
  ) {}

  async getAll() {
    return await this.userModel.find();
  }

  async getById(id: string) {
    return await this.userModel.findById(id);
  }

  async getByEmail(email: string) {
    return await this.userModel.findOne({ email });
  }

  async create(user: CreateUserDto) {
    const userExist = await this.getByEmail(user.email);

    if (userExist) {
      throw new BadRequestException('already registered user');
    }

    return await this.userModel.create({
      name: user.name,
      email: user.email,
      phone: user.phone,
      password: await this.bcryptService.encrypt(user.password),
    });
  }

  async findByIdAndUpdate(id: string, user: UpdateUserDto) {
    try {
      const exist = await this.userModel.findById(id);
      if (exist) {
        user.password
          ? (user.password = await this.bcryptService.encrypt(user.password))
          : (user.password = exist.password);
        return await this.userModel.findByIdAndUpdate(
          id,
          { $set: user },
          { new: true }
        );
      }
      throw new BadRequestException('user does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }

  async delete(id: string) {
    return await this.userModel.findByIdAndDelete(id);
  }
}
