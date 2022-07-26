import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:intl/intl.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';

import '../models/ceremony_model.dart';
import 'interfaces/ceremony_repository_interface.dart';

class CeremonyRepository implements ICeremonyRepository {
  final DioForNative _client;

  CeremonyRepository(this._client);

  @override
  Future<Either<Failure, CeremonyModel>> createCeremony(
      CeremonyModel model) async {
    try {
      var response = await _client.post('/ceremonys',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
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
      var response = await _client.delete('/ceremonys/$id',
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
  Future<Either<Failure, CeremonyModel>> getCeremony(String id) async {
    try {
      var response = await _client.get('/ceremonys/$id',
          options: Options(headers: {"requiresToken": "true"}));
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
      var response = await _client.patch('/ceremonys/${model.sId}',
          data: model.toJson(),
          options: Options(headers: {"requiresToken": "true"}));
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
      var response = await _client.get('/ceremonys',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var ceremonies = ResponseCeremonies.fromJson(response.data);
        return Right(ceremonies.ceremonies);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CeremonyModel>>> getCeremoniesOfDay(
      DateTime date) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      data['date'] = formattedDate;
      var response = await _client.post('/ceremonys/of-day',
          data: data, options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = ResponseCeremonies.fromJson(response.data);
        return Right(result.ceremonies);
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
