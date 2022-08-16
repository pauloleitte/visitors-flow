import { Controller, UseGuards, Request, Post, HttpCode } from '@nestjs/common';
import { LocalAuthGuard } from '../guards/local-auth.guard';
import { AuthService } from '../services/auth.service';

@Controller()
export class AuthController {

    constructor(
        private authService: AuthService,
    ) { }

    @UseGuards(LocalAuthGuard)
    @Post('auth/login')
    @HttpCode(200)
    async login(@Request() req: any) {
        return this.authService.login(req.user);
    }
}
