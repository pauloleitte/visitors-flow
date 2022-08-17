import 'package:flutter_modular/flutter_modular.dart';
import 'controllers/profile_controller.dart';
import 'pages/configuration_page.dart';
import 'pages/profile_page.dart';
import 'pages/security_page.dart';

class ConfigurationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ProfileController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ConfigurationPage()),
    ChildRoute('/profile', child: (_, args) => ProfilePage()),
    ChildRoute('/security', child: (_, args) => SecurityPage())
  ];
}
