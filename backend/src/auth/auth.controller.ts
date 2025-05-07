import { Controller, Get, Req } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Get('login')
  login(@Req() req: Request) {
    return 'hello login';
  }

  @Get('google')
  @UseGuards(AuthGuard('google'))
  @Get('google/callback')
  @UseGuards(AuthGuard('google'))
  googleAuthCallback(@Req() req: Request) {
    console.log('Google Auth Callback super debug Test');
    console.log(req);
    return 'Google Auth Callback';
  }
}
