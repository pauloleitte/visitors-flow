import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../shared/errors/errors.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../models/login_request_model.dart';
import '../models/signup_request_model.dart';
import '../models/user_create_model.dart';
import '../models/user_model.dart';
import '../repositories/interfaces/user_repository_interface.dart';
import '../view-models/login_view_model.dart';
import '../view-models/signup_view_model.dart';
import 'interfaces/user_service_interface.dart';

class UserService implements IUserService {
  final IUserRepository _userRepository;

  UserService(this._userRepository);

  @override
  void dispose() {}

  @override
  Future<UserModel> getCurrentUser() async {
    var contains = await LocalStorageService.cointains('current_user');
    if (contains) {
      var res = jsonDecode(
          await LocalStorageService.getValue<String>('current_user'));
      return UserModel.fromJson(res);
    } else {
      return UserModel();
    }
  }

  @override
  Future<void> saveLocalDB(UserModel user) async {
    LocalStorageService.setValue<String>(
        'current_user', jsonEncode(user.toJson()));
  }

  @override
  Future<Either<Failure, UserModel>> login(LoginViewModel model) async {
    return await _userRepository
        .login(LoginRequestModel(email: model.email, password: model.password));
  }

  @override
  Future<Either<Failure, UserCreateModel>> signup(SignupViewModel model) async {
    return await _userRepository.signup(SignupRequestModel(
        name: model.name,
        email: model.email,
        password: model.password,
        phone: model.phone));
  }
}
