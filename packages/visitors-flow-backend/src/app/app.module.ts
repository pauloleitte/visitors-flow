import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './core/modules/user/user.module';
import { AuthModule } from './core/modules/auth/auth.module';
import { VisitorModule } from './core/modules/visitor/visitor.module';
import { CeremonyModule } from './core/modules/ceremony/ceremony.module';
import { HealthModule } from './core/modules/health/health.module';
import { MongooseModule } from '@nestjs/mongoose';
import { NoticeModule } from './core/modules/notice/notice.module';
import { MemberModule } from './core/modules/member/member.module';
@Module({
  imports: [
    AuthModule,
    ConfigModule.forRoot(),
    MongooseModule.forRoot(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }),
    HealthModule,
    UserModule,
    VisitorModule,
    CeremonyModule,
    NoticeModule,
    MemberModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
