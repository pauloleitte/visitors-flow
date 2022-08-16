/* eslint-disable no-debugger */
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
import { CeremonyOfDayDTO } from './dto/ceremony-of-day.dto';
import { endOfDay, startOfDay } from 'date-fns';

@Injectable()
export class CeremonyService {
  constructor(
    @InjectModel('Ceremony') private readonly ceremonyModel: Model<Ceremony>
  ) {}

  async getAll(args: any) {
    const findQuery = this.ceremonyModel
      .find({
        name: { $regex: args.name ?? '', $options: 'i' },
      })
      .sort({ _id: 1 })
      .skip(args.documentsToSkip)
      .populate('visitors');
    if (args.limitOfDocuments) {
      findQuery.limit(args.imitOfDocuments);
    }
    const ceremonies = await findQuery;
    const count = await this.ceremonyModel.count();

    return { ceremonies, count };
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
  async findByIdAndUpdate(id: string, dto: UpdateCeremonyDTO) {
    try {
      const exist = await this.ceremonyModel.findById(id);
      if (exist) {
        return await this.ceremonyModel
          .findByIdAndUpdate(id, { $set: dto }, { new: true })
          .exec();
      }
      throw new BadRequestException('ceremony does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }

  async getCeremoniesOfDay(dto: CeremonyOfDayDTO) {
    const paramDate = new Date(dto.date);
    const query = this.ceremonyModel.find({
      date: { $gte: startOfDay(paramDate), $lte: endOfDay(paramDate) },
    });
    const ceremonies = await query;
    return { ceremonies };
  }
}
