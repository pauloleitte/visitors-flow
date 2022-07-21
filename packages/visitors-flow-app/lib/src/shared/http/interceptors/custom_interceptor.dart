import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/modules/auth/services/interfaces/user_service_interface.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var userService = Modular.get<IUserService>();
    var user = await userService.getCurrentUser();

    if (user.token != null && user.token!.isNotEmpty) {
      var headerAuth = genToken(user.token);
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

  String genToken(String? token) {
    return 'Bearer $token';
  }
}
