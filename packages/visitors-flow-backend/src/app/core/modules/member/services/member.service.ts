import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateMemberDTO } from '../dto/create-member.dto';
import { UpdateMemberDTO } from '../dto/update-member.dto';
import { Member } from '../schemas/member.schema';
@Injectable()
export class MemberService {
  constructor(
    @InjectModel('Member') private readonly memberModel: Model<Member>
  ) {}

  async getAll(documentsToSkip = 0, limitOfDocuments?: number, name?: string) {
    const query = this.memberModel
      .find(name ? { name: { $regex: name, $options: 'i' } } : {})
      .select('-__v')
      .sort({ _id: 1 })
      .skip(documentsToSkip);
      

    if (limitOfDocuments) {
      query.limit(limitOfDocuments);
    }
    const members = await query;
    const count = await this.memberModel.count();

    return { members, count };
  }

  async getById(id: string) {
    return await this.memberModel.findById(id);
  }

  async create(member: CreateMemberDTO) {
    return await this.memberModel.create(member);
  }

  async findByIdAndDelete(id: string) {
    return await this.memberModel.findByIdAndDelete(id).exec();
  }

  async findByIdAndUpdate(id: string, member: UpdateMemberDTO) {
    return await this.memberModel.findByIdAndUpdate(
      id,
      { $set: member },
      { new: true }
    );
  }

  async getBirthdayOfMonth() {
    const toDay = new Date();
    const members = await this.memberModel.find();
    return members.filter((member) => {
      if (member.birthday && member.birthday.getMonth() === toDay.getMonth()) {
        return true;
      }
      return false;
    });
  }
}
