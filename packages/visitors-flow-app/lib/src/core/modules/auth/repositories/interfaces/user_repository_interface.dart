import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../shared/errors/errors.dart';
import '../../models/login_request_model.dart';
import '../../models/signup_request_model.dart';
import '../../models/user_create_model.dart';
import '../../models/user_model.dart';

abstract class IUserRepository implements Disposable {
  Future<Either<Failure, UserModel>> login(LoginRequestModel model);
  Future<Either<Failure, UserCreateModel>> signup(SignupRequestModel model);
}
