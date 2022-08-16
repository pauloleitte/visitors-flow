import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Like, MongoRepository } from 'typeorm';
import * as uuid from 'uuid';
import { CreateVisitorDTO } from '../dto/create-visitor.dto';
import { UpdateVisitorDTO } from '../dto/update-visitor.dto';
import { Visitor } from '../entities/visitor.entity';

@Injectable()
export class VisitorRepository {
  constructor(
    @InjectRepository(Visitor)
    private readonly mongoRepositoryVisitor: MongoRepository<Visitor>
  ) {}

  async getAll(query: any) {
    const take = query.take || 10
    const skip = query.skip || 0
    const keyword = query.keyword || ''


    console.log(take, skip, keyword)
    const [result, total] = await this.mongoRepositoryVisitor.findAndCount(
        {
            where: { name: Like('%' + keyword + '%') }, order: { name: "DESC" },
            take: parseInt(take),
            skip: parseInt(skip)
        }
    );

    return {
        visitors: result,
        count: total
    }
  }

  async getById(id: string) {
    return await this.mongoRepositoryVisitor.findOneBy(id);
  }

  async findByIdAndUpdate(id: string, dto: UpdateVisitorDTO) {
    try {
      const exist = await this.mongoRepositoryVisitor.findOneBy({ _id: id });
      if (exist) {
        return await this.mongoRepositoryVisitor.findOneAndUpdate(
          { _id: id },
          { $set: dto }
        );
      }
      throw new BadRequestException('user does not exist');
    } catch (e) {
      throw new InternalServerErrorException(e);
    }
  }

  async delete(id: string) {
    return await this.mongoRepositoryVisitor.deleteOne({ _id: id });
  }

  async create(dto: CreateVisitorDTO) {
    const visitor = new Visitor();
    visitor._id = uuid.v4();
    visitor.name = dto.name;
    visitor.email = dto.email;
    visitor.telephone = dto.telephone;
    visitor.isChurchgoer = dto.isChurchgoer;
    visitor.church = dto.church;
    visitor.observations = dto.observations;
    return await this.mongoRepositoryVisitor.save(visitor);
  }
}
