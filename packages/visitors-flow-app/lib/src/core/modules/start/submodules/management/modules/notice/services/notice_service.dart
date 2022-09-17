import 'package:visitors_flow_app/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';
import '../models/notice_model.dart';
import '../repositories/intefaces/notice_repository_interface.dart';
import '../view-model/notice_view_model.dart';
import 'interfaces/notice_service_interface.dart';

class NoticeService implements INoticeService {
  final INoticeRepository _noticeRepository;

  NoticeService(this._noticeRepository);

  @override
  Future<Either<Failure, NoticeModel>> createNotice(
      NoticeViewModel notice) async {
    return await _noticeRepository.createNotice(NoticeModel(
      name: notice.name,
      isDone: notice.isDone,
      description: notice.description,
    ));
  }

  @override
  Future<Either<Failure, bool>> deleteNotice(NoticeViewModel notice) async {
    return await _noticeRepository.deleteNotice(notice.id!);
  }

  @override
  void dispose() {}

  @override
  Future<Either<Failure, NoticeModel>> getNotice(NoticeViewModel notice) {
    return _noticeRepository.getNotice(notice.id!);
  }

  @override
  Future<Either<Failure, List<NoticeModel>>> getNotices() {
    return _noticeRepository.getNotices();
  }

  @override
  Future<Either<Failure, NoticeModel>> updateNotice(NoticeViewModel notice) {
    return _noticeRepository.updateNotice(NoticeModel(
      sId: notice.id,
      name: notice.name,
      isDone: notice.isDone,
      description: notice.description,
    ));
  }
}
