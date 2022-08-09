import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/pages/start_page.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/ceremony_module.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/configuration_module.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/home/home_module.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/visitors/visitor_module.dart';

import 'store/start_store.dart';

class StartModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => StartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const StartPage(), children: [
      ModuleRoute(
        '/home',
        module: HomeModule(),
      ),
      ModuleRoute(
        '/ceremony',
        module: CeremonyModule(),
      ),
      ModuleRoute(
        '/visitor',
        module: VisitorModule(),
      ),
      ModuleRoute(
        '/config',
        module: ConfigurationModule(),
      ),
    ]),
  ];
}
