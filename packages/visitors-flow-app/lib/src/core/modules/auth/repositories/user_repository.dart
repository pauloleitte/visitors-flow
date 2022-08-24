import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:visitors_flow_app/src/core/config/app_enum.dart';
import 'package:visitors_flow_app/src/core/config/app_messages.dart';
import 'package:visitors_flow_app/src/core/modules/auth/models/user_model.dart';
import '../../../../shared/errors/errors.dart';
import '../models/login_request_model.dart';
import '../models/signup_request_model.dart';
import '../models/token_model.dart';
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
          message: AppMessages.ERROR_MESSAGE_AUTH,
          statusCode: response.statusCode));
    } on DioError catch (err) {
      if (err.response != null &&
          err.response?.statusCode != null &&
          err.response?.statusMessage != null) {
        return Left(DioFailure(
            message: AppEnum.statusCodeMap[err.response?.statusCode],
            statusCode: err.response?.statusCode));
      }
      return Left(DioFailure(message: AppMessages.ERROR_HTTP_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup(SignupRequestModel model) async {
    try {
      var response = await _client.post('/users', data: model.toJson());
      if (response.statusCode == HttpStatus.created) {
        return Right(UserModel.fromJson(response.data));
      }
      return Left(DioFailure(
          message: AppMessages.ERROR_HTTP_MESSAGE,
          statusCode: response.statusCode));
    } on DioError catch (err) {
      if (err.response != null &&
          err.response?.statusCode != null &&
          err.response?.statusMessage != null) {
        return Left(DioFailure(
            message: AppEnum.statusCodeMap[err.response?.statusCode],
            statusCode: err.response?.statusCode));
      }
      return Left(DioFailure(message: AppMessages.ERROR_HTTP_MESSAGE));
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
          message: AppMessages.ERROR_HTTP_MESSAGE,
          statusCode: response.statusCode));
    } on DioError catch (err) {
      if (err.response != null &&
          err.response?.statusCode != null &&
          err.response?.statusMessage != null) {
        return Left(DioFailure(
            message: AppEnum.statusCodeMap[err.response?.statusCode],
            statusCode: err.response?.statusCode));
      }
      return Left(DioFailure(message: AppMessages.ERROR_HTTP_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword(UserModel model) async {
    try {
      var response = await _client.patch('/users/${model.sId}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        return const Right(true);
      }
      return Left(DioFailure(
          message: AppMessages.ERROR_HTTP_MESSAGE,
          statusCode: response.statusCode));
    } on DioError catch (err) {
      if (err.response != null &&
          err.response?.statusCode != null &&
          err.response?.statusMessage != null) {
        return Left(DioFailure(
            message: AppEnum.statusCodeMap[err.response?.statusCode],
            statusCode: err.response?.statusCode));
      }
      return Left(DioFailure(message: AppMessages.ERROR_HTTP_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUser(UserModel model) async {
    try {
      var response = await _client.patch('/users/${model.sId}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = UserModel.fromJson(response.data);
        return Right(result);
      }
      return Left(DioFailure(
          message: AppMessages.ERROR_HTTP_MESSAGE,
          statusCode: response.statusCode));
    } on DioError catch (err) {
      if (err.response != null &&
          err.response?.statusCode != null &&
          err.response?.statusMessage != null) {
        return Left(DioFailure(
            message: AppEnum.statusCodeMap[err.response?.statusCode],
            statusCode: err.response?.statusCode));
      }
      return Left(DioFailure(message: AppMessages.ERROR_HTTP_MESSAGE));
    }
  }
}
