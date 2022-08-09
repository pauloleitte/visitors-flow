import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/errors/errors.dart';
import '../../../../../auth/models/user_model.dart';
import '../../view-models/user_view_model.dart';

abstract class IProfileService extends Disposable {
  Future<Either<Failure, bool>> updatePassword(UserModel model);
  Future<Either<Failure, UserModel>> updateUser(UserModel model);
}
