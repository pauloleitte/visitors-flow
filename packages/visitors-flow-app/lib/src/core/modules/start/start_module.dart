import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/pages/start_page.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/ceremony_module.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/profile/profile_module.dart';

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
        '/ceremony',
        module: CeremonyModule(),
      ),
      ModuleRoute(
        '/profile',
        module: ProfileModule(),
      ),
    ]),
  ];
}
