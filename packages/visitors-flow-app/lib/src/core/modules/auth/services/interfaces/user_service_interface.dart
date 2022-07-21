import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../shared/errors/errors.dart';
import '../../models/user_create_model.dart';
import '../../models/user_model.dart';
import '../../view-models/login_view_model.dart';
import '../../view-models/signup_view_model.dart';

abstract class IUserService implements Disposable {
  Future<UserModel> getCurrentUser();
  Future<void> saveLocalDB(UserModel user);
  Future<Either<Failure, UserModel>> login(LoginViewModel login);
  Future<Either<Failure, UserCreateModel>> signup(SignupViewModel signup);
}
