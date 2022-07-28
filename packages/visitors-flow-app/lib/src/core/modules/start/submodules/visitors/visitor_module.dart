import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/visitor_controller.dart';
import 'pages/visitor_page.dart';
import 'repositories/visitor_repository.dart';
import 'services/visitor_service.dart';

class VisitorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => VisitorRepository(i.get())),
    Bind.factory((i) => VisitorService(i.get())),
    Bind.factory((i) => VisitorController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => VisitorPage())
  ];
}
