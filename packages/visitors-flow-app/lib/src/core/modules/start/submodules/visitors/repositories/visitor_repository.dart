import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../../../../../../shared/errors/errors.dart';
import '../models/visitor_model.dart';
import 'interfaces/visitor_repository_interface.dart';

class VisitorRepository implements IVisitorRepository {
  final DioForNative _client;

  VisitorRepository(this._client);

  @override
  Future<Either<Failure, List<VisitorModel>>> getVisitors() async {
    try {
      var response = await _client.get('/visitors',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data as List)
            .map((e) => VisitorModel.fromJson(e))
            .toList();
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, VisitorModel>> getVisitor(String id) async {
    try {
      var response = await _client.get('/visitors/$id');
      if (response.statusCode == HttpStatus.ok) {
        var result = VisitorModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, VisitorModel>> createVisitor(
      VisitorModel model) async {
    try {
      var response = await _client.post('/visitors', data: model.toJson());
      if (response.statusCode == HttpStatus.created) {
        var result = VisitorModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, VisitorModel>> updateVisitor(
      VisitorModel model) async {
    try {
      var response = await _client.put('/visitors/${model.sId.toString()}',
          data: model.toJson());
      if (response.statusCode == HttpStatus.ok) {
        var result = VisitorModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteVisitor(String id) async {
    try {
      var response = await _client.delete('/visitors/$id');
      if (response.statusCode == HttpStatus.ok) {
        return Right(true);
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
