export class CreateUserDto {
    name: string;
    password: string;
    email: string;
    phone: string;
    roles?: string[];
    genre: string;
}
