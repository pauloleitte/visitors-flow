/* eslint-disable no-debugger */
import { InjectModel } from '@nestjs/mongoose';
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import {
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common/exceptions';
import { Ceremony } from '../schema/ceremony.schema';
import { CreateCeremonyDTO } from '../dto/create-ceremony.dto';
import { UpdateCeremonyDTO } from '../dto/update-ceremony.dto';
import { CeremonyOfDayDTO } from '../dto/ceremony-of-day.dto';
import { endOfDay, startOfDay } from 'date-fns';

@Injectable()
export class CeremonyService {
  constructor(
    @InjectModel('Ceremony') private readonly ceremonyModel: Model<Ceremony>
  ) {}
  async getAll(documentsToSkip = 0, limitOfDocuments?: number, name?: string) {
    const findQuery = this.ceremonyModel
      .find({
        name: { $regex: name ?? '', $options: 'i' },
      })
      .sort({ _id: 1 })
      .skip(documentsToSkip)
      .populate([{ path: 'visitors', strictPopulate: false }]);
    if (limitOfDocuments) {
      findQuery.limit(limitOfDocuments);
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
    console.log('dto', dto);
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
    const query = this.ceremonyModel
      .find({
        date: { $gte: startOfDay(paramDate), $lte: endOfDay(paramDate) },
      })
      .populate([{ path: 'visitors', strictPopulate: false }]);
    const ceremonies = await query;
    return { ceremonies };
  }
}
