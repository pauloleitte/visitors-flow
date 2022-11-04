import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/services/ceremony_service.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/member/repositories/member_repository.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/member/services/member_service.dart';

import '../notice/repositories/notice_repository.dart';
import '../notice/services/notice_service.dart';
import 'controllers/departament_controller.dart';
import 'pages/departament_form_page.dart';
import 'pages/departament_page.dart';
import 'repositories/departament_repository_dart.dart';

class DepartamentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => NoticeRepository(i.get())),
    Bind.factory((i) => NoticeService(i.get())),
    Bind.factory((i) => MemberRepository(i.get())),
    Bind.factory((i) => MemberService(i.get())),
    Bind.lazySingleton((i) => DepartamentRepository(i.get())),
    Bind.lazySingleton((i) => DepartamentService(i.get())),
    Bind.lazySingleton((i) => DepartamentController(i.get(), i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const DepartamentPage(),
    ),
    ChildRoute('/form',
        child: (_, args) => DepartamentFormPage(
              departament: args.data,
            )),
  ];
}
