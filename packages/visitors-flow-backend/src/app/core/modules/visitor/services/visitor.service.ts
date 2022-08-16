import { InjectModel } from '@nestjs/mongoose';
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import { Visitor } from '../schema/visitor.schema';
import { CreateVisitorDTO } from '../dto/create-visitor.dto';
import { UpdateVisitorDTO } from '../dto/update-visitor.dto';

@Injectable()
export class VisitorService {
  constructor(
    @InjectModel('Visitor') private readonly visitorModel: Model<Visitor>
  ) {}

  async getAll(documentsToSkip = 0, limitOfDocuments?: number, name?: string) {
    const query = this.visitorModel
      .find(name ? { name: { $regex: name, $options: 'i' } } : {})
      .sort({ _id: 1 })
      .skip(documentsToSkip);

    if (limitOfDocuments) {
      query.limit(limitOfDocuments);
    }
    const visitors = await query;
    const count = await this.visitorModel.count();

    return { visitors, count };
  }

  async getById(id: string) {
    return await this.visitorModel.findById(id);
  }

  async create(visitor: CreateVisitorDTO) {
    return await this.visitorModel.create(visitor);
  }

  async findByIdAndDelete(id: string) {
    return await this.visitorModel.findByIdAndDelete(id).exec();
  }

  async findByIdAndUpdate(id: string, visitor: UpdateVisitorDTO) {
    return await this.visitorModel.findByIdAndUpdate(
      id,
      { $set: visitor },
      { new: true }
    );
  }
}
