import { Module } from '@nestjs/common';
import { UserController } from './controllers/user.controller';
import { BcryptService } from '../../../shared/services/bcrypt.service';
import { UserRepository } from './repositories/user.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entities/user.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([User]),
  ],
  controllers: [UserController],
  providers: [BcryptService, UserRepository],
  exports: [UserRepository]
})
export class UserModule { }
