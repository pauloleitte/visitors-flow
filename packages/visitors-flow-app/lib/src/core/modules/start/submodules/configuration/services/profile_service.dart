import 'package:visitors_flow_app/src/core/modules/auth/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/services/interfaces/profile_service_interfaces.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

import '../repositories/interfaces/profile_repository_interface.dart';

class ProfileService implements IProfileService {
  IProfileRepository _repository;

  ProfileService(this._repository);

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<Either<Failure, bool>> updatePassword(UserModel model) async {
    return await _repository.updatePassword(model);
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserModel model) async {
    return await _repository.updateUser(model);
  }
}
