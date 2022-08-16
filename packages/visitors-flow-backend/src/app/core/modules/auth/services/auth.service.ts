import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { BcryptService } from '../../../../shared/services/bcrypt.service';
import { UserRepository } from '../../user/repositories/user.repository';
@Injectable()
export class AuthService {
  constructor(
    private userRepository: UserRepository,
    private jwtService: JwtService,
    private bcryptService: BcryptService
  ) {}

  async generateOTP() {
    const digits = '0123456789';
    let OTP = '';
    for (let i = 0; i < 4; i++) {
      OTP += digits[Math.floor(Math.random() * 10)];
    }
    return OTP;
  }

  async validateUser(email: string, password: string) {
    const user = await this.userRepository.getByEmail(email);
    if (user && (await this.bcryptService.compare(password, user.password))) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  async login(user: any) {
    const payload = { email: user.email, sub: user._id };
    return {
      auth: true,
      token: this.jwtService.sign(payload),
      name: user.name,
      email: user.email,
      phone: user.phone,
      id: user._id,
    };
  }
}
