import 'package:flutter_modular/flutter_modular.dart';

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
    ChildRoute('/form', child: (_, args) => const CeremonyFormPage()),
  ];
}