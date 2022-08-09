import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/pages/security_page.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/repositories/profile_repository.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/services/profile_service.dart';
import 'controllers/profile_controller.dart';
import 'pages/configuration_page.dart';
import 'pages/profile_page.dart';

class ConfigurationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ProfileRepository(i.get())),
    Bind.factory((i) => ProfileService(i.get())),
    Bind.factory((i) => ProfileController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ConfigurationPage()),
    ChildRoute('/profile', child: (_, args) => ProfilePage()),
    ChildRoute('/security', child: (_, args) => SecurityPage())
  ];
}
