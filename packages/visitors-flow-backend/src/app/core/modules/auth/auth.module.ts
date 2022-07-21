import { Module } from '@nestjs/common';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';

import { UsersModule } from './../users/users.module';
import { AuthController } from './controllers/auth.controller';
import { AuthService } from './services/auth.service';
import { LocalStrategy } from './strategy/local.strategy';
import { JwtStrategy } from './strategy/jtw.strategy';
import { ConfigModule } from '@nestjs/config';
import { BcryptService } from '../../../shared/services/bcrypt.service';


@Module({
    imports: [
        ConfigModule.forRoot(),
        UsersModule,
        PassportModule.register({ session: true }),
        JwtModule.register({
            secret: process.env.JWT_SECRET,
            signOptions: { expiresIn: '1day' },
        }),
    ],
    controllers: [
        AuthController,
    ],
    providers: [
        AuthService,
        LocalStrategy,
        JwtStrategy,
        BcryptService,
    ],
})
export class AuthModule { }