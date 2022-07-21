import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './core/modules/user/user.module';
import { AuthModule } from './core/modules/auth/auth.module';
import { VisitorModule } from './core/modules/visitor/visitor.module';
import { CeremonyModule } from './core/modules/ceremony/ceremony.module';
// import { MailerModule } from '@nestjs-modules/mailer';
// import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter';
// import * as path from 'path';

@Module({
  imports: [
    AuthModule,
    ConfigModule.forRoot(),
    // MailerModule.forRoot({
    //   transport: {
    //     host: process.env.HOST_MAIL,
    //     port: Number(process.env.PORT_MAIL),
    //     auth: {
    //       user: process.env.AUTH_EMAIL_USER,
    //       pass: process.env.AUTH_EMAIL_PASS,
    //     },
    //   },
    //   template: {
    //     dir: path.join(__dirname, 'mail/templates'),
    //     adapter: new HandlebarsAdapter(), // or new PugAdapter() or new EjsAdapter()
    //     options: {
    //       strict: false,
    //     },
    //   },
    // }),
    MongooseModule.forRoot(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }),
    UserModule,
    VisitorModule,
    CeremonyModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
