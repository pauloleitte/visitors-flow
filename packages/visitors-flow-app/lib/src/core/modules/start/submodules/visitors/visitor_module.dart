import 'package:flutter_modular/flutter_modular.dart';

import 'pages/visitor_page.dart';

class VisitorModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => VisitorPage())
  ];
}
