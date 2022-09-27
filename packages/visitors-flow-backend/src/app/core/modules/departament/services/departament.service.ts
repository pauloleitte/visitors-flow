/* eslint-disable no-debugger */
import { InjectModel } from '@nestjs/mongoose';
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import {
  BadRequestException,
  InternalServerErrorException,
} from '@nestjs/common/exceptions';
import { Departament } from '../schema/departament.schema';
import { CreateDepartamentDTO } from '../dto/create-departament.dto';
import { UpdateDepartamentDTO } from '../dto/update-departament.dto';
@Injectable()
export class DepartamentService {
  constructor(
    @InjectModel('Departament')
    private readonly departamentModel: Model<Departament>
  ) {}
  async getAll(documentsToSkip = 0, limitOfDocuments?: number, name?: string) {
    const findQuery = this.departamentModel
      .find({
        name: { $regex: name ?? '', $options: 'i' },
      })
      .sort({ _id: 1 })
      .skip(documentsToSkip)
      .select('-__v')
      .populate([
        { path: 'members', strictPopulate: false },
        { path: 'notices', strictPopulate: false },
      ])
      .select('-__v');
    if (limitOfDocuments) {
      findQuery.limit(limitOfDocuments);
    }
    const departaments = await findQuery;
    const count = await this.departamentModel.count();

    return { departaments, count };
  }

  async getById(id: string) {
    return await await this.departamentModel
      .findById(id)
      .select('-__v')
      .populate([
        { path: 'members', strictPopulate: false },
        { path: 'notices', strictPopulate: false },
      ]);
  }

  async delete(id: string) {
    return await this.departamentModel.findByIdAndDelete(id);
  }

  async create(departament: CreateDepartamentDTO) {
    return await this.departamentModel.create(departament);
  }
  async findByIdAndUpdate(id: string, dto: UpdateDepartamentDTO) {
    try {
      const exist = await this.departamentModel.findById(id);
      if (exist) {
        return await this.departamentModel
          .findByIdAndUpdate(id, { $set: dto }, { new: true })
          .select('-__v')
          .populate([
            { path: 'members', strictPopulate: false },
            { path: 'notices', strictPopulate: false },
          ])
          .exec();
      }
      throw new BadRequestException('departament does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }
}
