// ignore: file_names
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/start_module.dart';

import 'core/config/app_routes.dart';
import 'core/modules/auth/auth_module.dart';
import 'core/modules/auth/repositories/user_repository.dart';
import 'core/modules/auth/services/user_service.dart';
import 'core/modules/auth/stores/user_store.dart';
import 'core/modules/splash/pages/splash_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DioForNative(i.get())),
    Bind((i) => UserService(i.get())),
    Bind((i) => UserRepository(i.get())),
    Bind((i) => UserStore(i.get())),
    Bind(
      (i) => BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        baseUrl: 'http://192.168.0.12:3333/api/v1',
        connectTimeout: 5000,
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AppRoutes.AUTH, module: AuthModule()),
    ModuleRoute(AppRoutes.START, module: StartModule()),
    ChildRoute(AppRoutes.SPLASH, child: (_, __) => const SplashPage()),
  ];
}
