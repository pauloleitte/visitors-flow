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
      .select('-__v')
      .populate([
        { path: 'visitors', strictPopulate: false },
        { path: 'notices', strictPopulate: false },
      ])
      .select('-__v');
    if (limitOfDocuments) {
      findQuery.limit(limitOfDocuments);
    }
    const ceremonies = await findQuery;
    const count = await this.ceremonyModel.count();

    return { ceremonies, count };
  }

  async getById(id: string) {
    return await await this.ceremonyModel
      .findById(id)
      .select('-__v')
      .populate([
        { path: 'visitors', strictPopulate: false },
        { path: 'notices', strictPopulate: false },
      ]);
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
          .select('-__v')
          .populate([
            { path: 'visitors', strictPopulate: false },
            { path: 'notices', strictPopulate: false },
          ])
          .exec();
      }
      throw new BadRequestException('ceremony does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }

  async getCeremoniesOfDay(dto: CeremonyOfDayDTO) {
    const startOfDay = new Date(dto.date + 'T00:00:00.000Z');
    const endOfDay = new Date(dto.date + 'T23:59:59.999Z');
    const query = this.ceremonyModel
      .find({
        date: { $gte: startOfDay, $lte: endOfDay },
      })
      .populate([
        { path: 'visitors', strictPopulate: false },
        { path: 'notices', strictPopulate: false },
      ])
      .select('-__v');
    const ceremonies = await query;
    return { ceremonies };
  }
}
