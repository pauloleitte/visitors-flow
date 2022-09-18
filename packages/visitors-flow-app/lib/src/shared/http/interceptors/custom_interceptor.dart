// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/auth/services/interfaces/token_service_interface.dart';
import 'package:visitors_flow_app/src/core/modules/auth/services/interfaces/user_service_interface.dart';

import '../../../core/modules/auth/models/token_model.dart';
import '../../../core/modules/auth/models/user_model.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("requiresToken")) {
      var tokenService = Modular.get<ITokenService>();
      var token = await tokenService.getCurrentToken();

      if (token.accessToken != null && token.accessToken!.isNotEmpty) {
        var headerAuth = genToken(token.accessToken);
        options.headers['Authorization'] = headerAuth;
      }
      if (kDebugMode) {
        debugPrint(json.encode("BaseURL: ${options.baseUrl}"));
        debugPrint(json.encode("Endpoint: ${options.path}"));
        if (options.headers['Authorization'] != null) {
          debugPrint("Authorization: ${options.headers['Authorization']}");
        }
        if (options.data != null) {
          debugPrint("Payload ${json.encode(options.data)}");
        }
      }
      return super.onRequest(options, handler);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.error.runtimeType != 'String') {
      Modular.get<ITokenService>().saveLocalDB(TokenModel());
      Modular.get<IUserService>().saveLocalDB(UserModel());
      Modular.to.navigate(AppRoutes.AUTH);
    }
    return super.onError(err, handler);
  }

  String genToken(String? token) {
    return 'Bearer $token';
  }
}
