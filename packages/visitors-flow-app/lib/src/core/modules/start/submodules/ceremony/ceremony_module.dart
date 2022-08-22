import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/pages/ceremony_report_page.dart';

import 'controllers/ceremony_controller.dart';
import 'pages/ceremony_form_page.dart';
import 'pages/ceremony_page.dart';
import 'repositories/ceremony_repository.dart';
import 'services/ceremony_service.dart';

class CeremonyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => CeremonyRepository(i.get())),
    Bind.factory((i) => CeremonyService(i.get())),
    Bind.factory((i) => CeremonyController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const CeremonyPage(),
    ),
    ChildRoute('/form',
        child: (_, args) => CeremonyFormPage(
              ceremony: args.data,
            )),
    ChildRoute('/report',
        child: (_, args) => CeremonyReportPage(
              ceremony: args.data,
            ))
  ];
}
