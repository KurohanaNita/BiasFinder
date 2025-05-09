import { Response } from 'express';
import { Controller, Get, Redirect, Req, Res } from '@nestjs/common';
import { AuthService } from './auth.service';
import { UsersService } from '../users/users.service';
import { UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly usersService: UsersService,
  ) {}

  @Get('login')
  login(@Req() req: Request) {
    return 'hello login';
  }

  @Get('google')
  @UseGuards(AuthGuard('google'))
  googleLogin() {}

  @Get('google/callback')
  @UseGuards(AuthGuard('google'))
  async googleAuthCallback(
    @Req() req: Request & { user: any },
    @Res() res: Response,
  ) {
    //console.log(req);
    console.log('Google Auth Callback super debug Test');
    console.log(req.user);
    // Here we need to handle the logic in case the user connects through Google but dont have an account
    // either we generate a dummy username for him and he change it later or we redirect him to a page to fill its infos
    await this.usersService.findOrCreateUser(req.user);
    res.redirect('http://localhost:3000/');
  }

  @Get('google/redirect')
  @Redirect('http://localhost:3000/', 301)
  handleGoogleRedirect() {
    console.log('Google Redirect super debug Test');
  }
}
