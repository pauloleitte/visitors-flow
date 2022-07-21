import { InjectModel } from '@nestjs/mongoose';
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import {
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common/exceptions';
import { Visitor } from './schema/visitor.schema';
import { CreateVisitorDTO } from './dto/create-visitor.dto';
import { UpdateVisitorDTO } from './dto/update-visitor.dto';

@Injectable()
export class VisitorService {
  constructor(
    @InjectModel('Visitor') private readonly visitorModel: Model<Visitor>
  ) {}

  async getAll() {
    return await this.visitorModel.find().exec();
  }

  async getById(id: string) {
    return await this.visitorModel.findById(id).exec();
  }

  async getByName(name: string) {
    return await this.visitorModel.findOne({ name }).exec();
  }

  async create(visitor: CreateVisitorDTO) {
    const visitorExist = await this.getByName(visitor.name);

    if (visitorExist) {
      throw new BadRequestException('already registered visitor');
    }

    return await this.visitorModel.create(visitor);
  }

  async findByIdAndUpdate(id: string, visitor: UpdateVisitorDTO) {
    try {
      const exist = await this.visitorModel.findById(id);
      if (exist) {
        return await this.visitorModel
          .findByIdAndUpdate(id, { $set: visitor }, { new: true })
          .exec();
      }
      throw new BadRequestException('visitor does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }
}
