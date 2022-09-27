import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/models/departament_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/repositories/interfaces/departament_repository_interface.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

class DepartamentRepository implements IDepartamentRepository {
  final DioForNative _client;

  DepartamentRepository(this._client);

  @override
  Future<Either<Failure, DepartamentModel>> createDepartament(
      DepartamentModel model) async {
    try {
      var response = await _client.post('/departaments',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.created) {
        var result = DepartamentModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDepartament(String id) async {
    try {
      var response = await _client.delete('/departaments/$id',
          options: Options(headers: {"requiresToken": true}));
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
  Future<Either<Failure, DepartamentModel>> getDepartament(String id) async {
    try {
      var response = await _client.get('/departaments/$id',
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = DepartamentModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, DepartamentModel>> updateDepartament(
      DepartamentModel model) async {
    try {
      var response = await _client.patch('/departaments/${model.sId}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
      if (response.statusCode == HttpStatus.ok) {
        var result = DepartamentModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DepartamentModel>>> getDepartaments() async {
    try {
      var response = await _client.get('/departaments',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var departaments = ResponseDepartaments.fromJson(response.data);
        return Right(departaments.departaments);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  void dispose() {}
}
