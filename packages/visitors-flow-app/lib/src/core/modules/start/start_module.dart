import 'package:flutter_modular/flutter_modular.dart';

import 'pages/start_page.dart';
import 'store/start_store.dart';
import 'submodules/ceremony/ceremony_module.dart';
import 'submodules/configuration/configuration_module.dart';
import 'submodules/home/home_module.dart';
import 'submodules/member/member.module.dart';
import 'submodules/notice/notice.module.dart';
import 'submodules/visitors/visitor_module.dart';

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
        '/notice',
        module: NoticeModule(),
      ),
      ModuleRoute(
        '/member',
        module: MemberModule(),
      ),
      ModuleRoute(
        '/config',
        module: ConfigurationModule(),
      ),
    ]),
  ];
}
