import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../shared/errors/errors.dart';
import '../../../start/submodules/configuration/models/update-password.model.dart';
import '../../models/login_request_model.dart';
import '../../models/signup_request_model.dart';
import '../../models/token_model.dart';
import '../../models/user_create_model.dart';
import '../../models/user_model.dart';

abstract class IUserRepository implements Disposable {
  Future<Either<Failure, TokenModel>> login(LoginRequestModel model);
  Future<Either<Failure, UserCreateModel>> signup(SignupRequestModel model);
  Future<Either<Failure, UserModel>> getUser(TokenModel model);
  Future<Either<Failure, bool>> updatePassword(UpdatePasswordModel model);
  Future<Either<Failure, UserModel>> updateUser(UserModel model);
}
