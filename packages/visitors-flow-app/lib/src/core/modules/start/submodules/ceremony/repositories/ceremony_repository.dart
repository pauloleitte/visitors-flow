import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../../../../../../shared/errors/errors.dart';
import '../models/ceremony_model.dart';
import 'interfaces/ceremony_repository_interface.dart';

class CeremonyRepository implements ICeremonyRepository {
  final DioForNative _client;

  CeremonyRepository(this._client);

  @override
  Future<Either<Failure, CeremonyModel>> createCeremony(
      CeremonyModel model) async {
    try {
      var response = await _client.post('/ceremonys', data: model.toJson());
      if (response.statusCode == HttpStatus.created) {
        var result = CeremonyModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCeremony(String id) async {
    try {
      var response = await _client.delete('/ceremonys/$id');
      if (response.statusCode == HttpStatus.noContent) {
        return const Right(true);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CeremonyModel>> getCeremony(String id) async {
    try {
      var response = await _client.get('/ceremonys/$id');
      if (response.statusCode == HttpStatus.ok) {
        var result = CeremonyModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CeremonyModel>> updateCeremony(
      CeremonyModel model) async {
    try {
      var response =
          await _client.put('/ceremonys/${model.sId}', data: model.toJson());
      if (response.statusCode == HttpStatus.ok) {
        var result = CeremonyModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CeremonyModel>>> getCeremonies() async {
    try {
      var response = await _client.get('/ceremonys');
      if (response.statusCode == HttpStatus.ok) {
        var result = (response.data as List)
            .map((e) => CeremonyModel.fromJson(e))
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
  void dispose() {
    // TODO: implement dispose
  }
}
