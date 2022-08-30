import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/models/member_model.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

abstract class IMemberRepository extends Disposable {
  Future<Either<Failure, List<MemberModel>>> getMembers();
  Future<Either<Failure, MemberModel>> getMember(String id);
  Future<Either<Failure, MemberModel>> createMember(MemberModel member);
  Future<Either<Failure, MemberModel>> updateMember(MemberModel member);
  Future<Either<Failure, bool>> deleteMember(String id);
}
