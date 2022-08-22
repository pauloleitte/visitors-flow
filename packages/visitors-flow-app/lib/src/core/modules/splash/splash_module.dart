import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/splash/controllers/splash_controller.dart';
import 'package:visitors_flow_app/src/core/modules/splash/pages/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SplashController(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashPage()),
  ];
}
