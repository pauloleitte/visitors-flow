import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:visitors_flow_app/src/shared/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../models/member_model.dart';
import 'interfaces/member_repository_interface.dart';

class MemberRepository implements IMemberRepository {
  final DioForNative _client;

  MemberRepository(this._client);

  @override
  Future<Either<Failure, MemberModel>> createMember(MemberModel member) async {
    try {
      var response = await _client.post('/members',
          data: member.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.created) {
        var result = MemberModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMember(String id) async {
    try {
      var response = await _client.delete('/members/$id',
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
  void dispose() {}

  @override
  Future<Either<Failure, MemberModel>> getMember(String id) async {
    try {
      var response = await _client.get('/members/$id',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = MemberModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MemberModel>>> getMembers() async {
    try {
      var response = await _client.get('/members',
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var data = ResponseMembers.fromJson(response.data);
        return Right(data.members);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }

  @override
  Future<Either<Failure, MemberModel>> updateMember(MemberModel member) async {
    try {
      var response = await _client.patch('/members/${member.sId.toString()}',
          data: member.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == HttpStatus.ok) {
        var result = MemberModel.fromJson(response.data);
        return Right(result);
      }
      return Left(
          DioFailure(message: 'ocorreu um erro durante o processamento'));
    } on DioError catch (err) {
      return Left(DioFailure(message: err.message.toString()));
    }
  }
}
