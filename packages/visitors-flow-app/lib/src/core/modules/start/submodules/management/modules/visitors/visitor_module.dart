import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/ceremony/repositories/ceremony_repository.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/ceremony/services/ceremony_service.dart';

import 'controllers/visitor_controller.dart';
import 'pages/visitor_page.dart';
import 'pages/visitor_page_form.dart';
import 'repositories/visitor_repository.dart';
import 'services/visitor_service.dart';

class VisitorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => CeremonyRepository(i.get())),
    Bind.factory((i) => CeremonyService(i.get())),
    Bind.factory((i) => VisitorRepository(i.get())),
    Bind.factory((i) => VisitorService(i.get())),
    Bind.factory((i) => VisitorController(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const VisitorPage()),
    ChildRoute('/form',
        child: (_, args) => VisitorPageForm(
              visitor: args.data,
            ))
  ];
}
