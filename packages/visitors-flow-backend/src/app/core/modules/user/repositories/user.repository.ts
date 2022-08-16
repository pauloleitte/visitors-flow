import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { BcryptService } from '../../../../shared/services/bcrypt.service';
import { MongoRepository } from 'typeorm';
import * as uuid from 'uuid';
import { CreateUserDto } from '../dto/create-user.dto';
import { UpdateUserDto } from '../dto/update-user.dto';
import { User } from '../entities/user.entity';

@Injectable()
export class UserRepository {
  constructor(
    @InjectRepository(User)
    private readonly mongoRepositoryUser: MongoRepository<User>,
    private readonly bcryptService: BcryptService
  ) {}

  async getAll() {
    return await this.mongoRepositoryUser.find();
  }

  async getById(id: string) {
    return await this.mongoRepositoryUser.findOneBy(id);
  }

  async getByEmail(email: string) {
    const exist = await this.mongoRepositoryUser.findOne({ where: { email: email } });
    if(exist.email) return exist;
    throw new BadRequestException('user does not exist');
  }

  async findByIdAndUpdate(id: string, user: UpdateUserDto) {
    try {
      const exist = await this.mongoRepositoryUser.findOneBy({ _id: id });
      if (exist) {
        user.password
          ? (user.password = await this.bcryptService.encrypt(user.password))
          : (user.password = exist.password);
        return await this.mongoRepositoryUser.findOneAndUpdate(
          { _id: id },
          { $set: user }
        );
      }
      throw new BadRequestException('user does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }

  async delete(id: string) {
    return await this.mongoRepositoryUser.deleteOne({ _id: id });
  }

  async create(input: CreateUserDto): Promise<User> {
    const userExist = await this.getByEmail(input.email);

    if (userExist) {
      throw new BadRequestException('already registered user');
    }
    const user = new User();
    user._id = uuid.v4();
    user.name = input.name;
    user.email = input.email;
    user.phone = input.phone;
    user.password = await this.bcryptService.encrypt(input.password);
    return await this.mongoRepositoryUser.save(user);
  }
}
