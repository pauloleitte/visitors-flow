import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/controllers/member_controller.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/pages/member_form_page.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/pages/member_page.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/repositories/member_repository.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/services/member_service.dart';

class MemberModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => MemberRepository(i.get())),
    Bind.factory((i) => MemberService(i.get())),
    Bind.factory((i) => MemberController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const MemeberPage(),
    ),
    ChildRoute('/form',
        child: (_, args) => MemberFormPage(
              member: args.data,
            )),
  ];
}
