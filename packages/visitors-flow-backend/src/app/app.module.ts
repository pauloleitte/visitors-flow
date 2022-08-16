import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './core/modules/user/user.module';
import { AuthModule } from './core/modules/auth/auth.module';
import { VisitorModule } from './core/modules/visitor/visitor.module';
import { CeremonyModule } from './core/modules/ceremony/ceremony.module';
import { HealthModule } from './core/modules/health/health.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './core/modules/user/entities/user.entity';
import { Visitor } from './core/modules/visitor/entities/visitor.entity';
@Module({
  imports: [
    AuthModule,
    ConfigModule.forRoot(),
    TypeOrmModule.forRoot({
      type: 'mongodb',
      url: process.env.MONGO_URI,
      entities: [User, Visitor],
      synchronize: true,
      useNewUrlParser: true,
      logging: true,
    }),
    HealthModule,
    UserModule,
    VisitorModule,
    // CeremonyModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
