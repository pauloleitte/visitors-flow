import 'package:flutter_modular/flutter_modular.dart';

import '../notice/repositories/notice_repository.dart';
import '../notice/services/notice_service.dart';
import '../visitors/repositories/visitor_repository.dart';
import '../visitors/services/visitor_service.dart';
import 'controllers/ceremony_controller.dart';
import 'pages/ceremony_form_page.dart';
import 'pages/ceremony_page.dart';
import 'repositories/ceremony_repository.dart';
import 'services/ceremony_service.dart';

class CeremonyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => NoticeRepository(i.get())),
    Bind.factory((i) => NoticeService(i.get())),
    Bind.factory((i) => VisitorRepository(i.get())),
    Bind.factory((i) => VisitorService(i.get())),
    Bind.factory((i) => CeremonyRepository(i.get())),
    Bind.factory((i) => CeremonyService(i.get())),
    Bind.factory((i) => CeremonyController(i.get(), i.get(), i.get())),
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
  ];
}
