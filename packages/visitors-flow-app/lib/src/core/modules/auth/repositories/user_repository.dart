import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:visitors_flow_app/src/core/modules/auth/models/user_model.dart';
import '../../../../shared/errors/errors.dart';
import '../../start/submodules/configuration/models/update-password.model.dart';
import '../models/login_request_model.dart';
import '../models/signup_request_model.dart';
import '../models/token_model.dart';
import '../models/user_create_model.dart';
import 'interfaces/user_repository_interface.dart';

class UserRepository implements IUserRepository {
  final DioForNative _client;

  UserRepository(this._client);

  @override
  void dispose() {}

  @override
  Future<Either<Failure, TokenModel>> login(LoginRequestModel model) async {
    try {
      var response = await _client.post('/auth/login', data: model.toJson());
      if (response.statusCode == HttpStatus.ok) {
        var result = TokenModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(
          message: 'Usuário ou senha inválidos',
          statusCode: response.statusCode));
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response!.data[0].message,
          statusCode: err.response!.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserCreateModel>> signup(
      SignupRequestModel model) async {
    try {
      var response = await _client.post('/users', data: model.toJson());
      if (response.statusCode == HttpStatus.created) {
        return Right(UserCreateModel.fromJson(response.data));
      }
      return Left(DioFailure(
          message: 'Ocorreu um erro por favor tente novamente',
          statusCode: response.statusCode));
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response!.data, statusCode: err.response!.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(TokenModel model) async {
    try {
      var response =
          await _client.post('/auth/info', data: model.toJsonAccessToken());
      if (response.statusCode == HttpStatus.ok) {
        return Right(UserModel.fromJson(response.data));
      }
      return Left(DioFailure(
          message: 'Ocorreu um erro por favor tente novamente',
          statusCode: response.statusCode));
    } on DioError catch (err) {
      return Left(DioFailure(
          message: err.response!.data, statusCode: err.response!.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword(
      UpdatePasswordModel model) async {
    try {
      var response = await _client.patch('/users/${model.id}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        return const Right(true);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserModel model) async {
    try {
      var response = await _client.patch('/users/${model.id}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = UserModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
