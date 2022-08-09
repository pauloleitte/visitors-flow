import { InjectModel } from '@nestjs/mongoose';
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import {
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common/exceptions';
import { Ceremony } from './schema/ceremony.schema';
import { CreateCeremonyDTO } from './dto/create-ceremony.dto';
import { UpdateCeremonyDTO } from './dto/update-ceremony.dto';
import { exit } from 'process';

@Injectable()
export class CeremonyService {
  constructor(
    @InjectModel('Ceremony') private readonly ceremonyModel: Model<Ceremony>
  ) {}

  async getAll() {
    return await this.ceremonyModel.find().populate('visitors');
  }

  async getById(id: string) {
    return await (await this.ceremonyModel.findById(id)).populated('visitors');
  }

  async delete(id: string) {
    return await this.ceremonyModel.findByIdAndDelete(id);
  }

  async create(ceremony: CreateCeremonyDTO) {
    return await this.ceremonyModel.create(ceremony);
  }
  async findByIdAndUpdate(id: string, ceremony: UpdateCeremonyDTO) {
    try {
      const exist = await this.ceremonyModel.findById(id);
      if (exist) {
        return await this.ceremonyModel.findByIdAndUpdate(
          id,
          { $set: ceremony },
          { new: true }
        );
      }
      throw new BadRequestException('ceremony does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }
}
