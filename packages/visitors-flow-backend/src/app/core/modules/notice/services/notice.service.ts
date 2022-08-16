import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateNoticeDTO } from '../dto/create-notice.dto';
import { UpdateNoticeDTO } from '../dto/update-notice.dto';
import { Notice } from '../schemas/notice.schemas';

@Injectable()
export class NoticeService {
  constructor(
    @InjectModel('Notice') private readonly noticeModel: Model<Notice>
  ) {}

  async getAll(documentsToSkip = 0, limitOfDocuments?: number, name?: string) {
    const query = this.noticeModel
      .find(name ? { name: { $regex: name, $options: 'i' } } : {})
      .sort({ _id: 1 })
      .skip(documentsToSkip);

    if (limitOfDocuments) {
      query.limit(limitOfDocuments);
    }
    const notices = await query;
    const count = await this.noticeModel.count();

    return { notices, count };
  }

  async getById(id: string) {
    return await this.noticeModel.findById(id);
  }

  async create(notice: CreateNoticeDTO) {
    return await this.noticeModel.create(notice);
  }

  async findByIdAndDelete(id: string) {
    return await this.noticeModel.findByIdAndDelete(id).exec();
  }

  async findByIdAndUpdate(id: string, notice: UpdateNoticeDTO) {
    return await this.noticeModel.findByIdAndUpdate(
      id,
      { $set: notice },
      { new: true }
    );
  }
}
