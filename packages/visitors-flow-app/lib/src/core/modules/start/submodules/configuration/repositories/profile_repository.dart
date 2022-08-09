import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:visitors_flow_app/src/core/modules/auth/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/repositories/interfaces/profile_repository_interface.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

class ProfileRepository implements IProfileRepository {
  final DioForNative _client;
  ProfileRepository(this._client);

  @override
  Future<Either<Failure, bool>> updatePassword(UserModel model) async {
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

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
