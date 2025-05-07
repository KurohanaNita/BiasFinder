import { Module } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { ConfigModule } from '@nestjs/config';

ConfigModule.forRoot({
  isGlobal: true,
  envFilePath: './.env',
});

@Module({
  imports: [UsersModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
