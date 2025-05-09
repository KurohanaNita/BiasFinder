import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { PrismaModule } from '../prisma/prisma.module';
import { GoogleStrategy } from './strategies/google.strategy';
import { UsersService } from '../users/users.service';

@Module({
  imports: [PrismaModule],
  controllers: [AuthController],
  providers: [AuthService, GoogleStrategy, UsersService],
})
export class AuthModule {}
