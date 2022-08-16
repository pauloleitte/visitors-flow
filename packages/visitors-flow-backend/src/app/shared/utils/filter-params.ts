import { IsNumber, IsOptional, Min } from 'class-validator';
import { Type } from 'class-transformer';

export class FilterParams {

  @IsOptional()
  @Type(() => String)
  name?: string;
  
  @IsOptional()
  @Type(() => String)
  @IsNumber()
  @Min(0)
  skip?: number;

  @IsOptional()
  @Type(() => String)
  @IsNumber()
  @Min(1)
  take?: number;
}