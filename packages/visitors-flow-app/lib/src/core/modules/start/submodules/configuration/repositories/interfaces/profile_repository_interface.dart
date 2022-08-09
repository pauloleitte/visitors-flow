import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/auth/models/user_model.dart';

import '../../../../../../../shared/errors/errors.dart';

abstract class IProfileRepository implements Disposable {
  Future<Either<Failure, bool>> updatePassword(UserModel model);
  Future<Either<Failure, UserModel>> updateUser(UserModel model);
}
