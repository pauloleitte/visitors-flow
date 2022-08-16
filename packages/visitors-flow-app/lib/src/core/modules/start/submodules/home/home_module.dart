import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/repositories/ceremony_repository.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/services/ceremony_service.dart';

import 'controllers/home_controller.dart';
import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CeremonyRepository(i.get())),
    Bind((i) => CeremonyService(i.get())),
    Bind((i) => HomeController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage())
  ];
}
