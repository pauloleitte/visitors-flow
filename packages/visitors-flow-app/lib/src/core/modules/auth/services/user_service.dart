import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../shared/errors/errors.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../../start/submodules/configuration/view-models/user_view_model.dart';
import '../models/login_request_model.dart';
import '../models/signup_request_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';
import '../repositories/interfaces/user_repository_interface.dart';
import '../view-models/login_view_model.dart';
import '../view-models/signup_view_model.dart';
import 'interfaces/token_service_interface.dart';
import 'interfaces/user_service_interface.dart';

class UserService implements IUserService {
  final IUserRepository _userRepository;
  final ITokenService _tokenService;

  UserService(this._userRepository, this._tokenService);

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
  Future<Either<Failure, TokenModel>> login(LoginViewModel model) async {
    return await _userRepository
        .login(LoginRequestModel(email: model.email, password: model.password));
  }

  @override
  Future<Either<Failure, UserModel>> signup(SignupViewModel model) async {
    return await _userRepository.signup(SignupRequestModel(
        name: model.name,
        email: model.email,
        password: model.password,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    var token = await _tokenService.getCurrentToken();
    return _userRepository.getUser(token);
  }

  @override
  Future<Either<Failure, bool>> updatePassword(UserViewModel model) async {
    return await _userRepository.updatePassword(UserModel(
        sId: model.id,
        name: model.name,
        email: model.email,
        password: model.password,
        phone: model.phone));
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserViewModel model) async {
    return await _userRepository.updateUser(UserModel(
        sId: model.id,
        name: model.name,
        email: model.email,
        phone: model.phone));
  }
}
