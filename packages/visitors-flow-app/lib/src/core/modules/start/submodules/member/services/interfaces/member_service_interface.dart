import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/errors/errors.dart';
import '../../models/member_model.dart';
import '../../view-model/member_view_model.dart';

abstract class IMemberService extends Disposable {
  Future<Either<Failure, List<MemberModel>>> getMembers();
  Future<Either<Failure, MemberModel>> getMember(MemberViewModel notice);
  Future<Either<Failure, MemberModel>> createMember(MemberViewModel notice);
  Future<Either<Failure, MemberModel>> updateMember(MemberViewModel notice);
  Future<Either<Failure, bool>> deleteMember(MemberViewModel notice);
}
