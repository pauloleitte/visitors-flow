import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';
import '../models/notice_model.dart';
import 'intefaces/notice_repository_interface.dart';

class NoticeRepository implements INoticeRepository {
  final DioForNative _client;

  NoticeRepository(this._client);

  @override
  Future<Either<Failure, NoticeModel>> createNotice(NoticeModel notice) async {
    try {
      var response = await _client.post('/notices',
          data: notice.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = NoticeModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotice(String id) async {
    try {
      var response = await _client.delete('/notices/$id',
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
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<Either<Failure, NoticeModel>> getNotice(String id) async {
    try {
      var response = await _client.get('/notices/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = NoticeModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NoticeModel>>> getNotices() async {
    try {
      var response = await _client.get('/notices',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseNotices.fromJson(response.data);
        return Right(data.notices);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, NoticeModel>> updateNotice(NoticeModel notice) async {
    try {
      var response = await _client.patch('/notices/${notice.sId.toString()}',
          data: notice.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = NoticeModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
