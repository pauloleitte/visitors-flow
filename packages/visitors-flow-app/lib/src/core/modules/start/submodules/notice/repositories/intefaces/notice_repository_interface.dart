import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

import '../../models/notice_model.dart';

abstract class INoticeRepository extends Disposable {
  Future<Either<Failure, List<NoticeModel>>> getNotices();
  Future<Either<Failure, NoticeModel>> getNotice(String id);
  Future<Either<Failure, NoticeModel>> createNotice(NoticeModel notice);
  Future<Either<Failure, NoticeModel>> updateNotice(NoticeModel notice);
  Future<Either<Failure, bool>> deleteNotice(String id);
}
